Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+XQI+PfBmckarqcQ4Nyko7nV/iZp7hf4qML0gSmgl84/RrtdpcSWrR0dC/upp9YEJE+OPb
ARC-Seal: i=1; a=rsa-sha256; t=1524405971; cv=none;
        d=google.com; s=arc-20160816;
        b=lc2TKn/YdBz4MdNbkM111h5Mlru4GhmwyHsl4+cDbNub4pjg/2RkOxrOo45WR0ucAG
         8OoQS0xNr5P1cB94G/4s/bceoBjN2JkqD97uxx+6TKGivtwDBxXIyFq5Gow/ziUtyvXS
         d/nvxkP6DvDM2CTcUMFiQk5onfJbzJxMxZEwwKtCbx3rrQOkK1VNVnyx0C3B25uy+uKz
         Ik2t7LYoMU9X0t1HnnLWSQugUcsq7Sraas4bVXPHb1iT31LYp6XsyJ4TmRNbH4lDcqnl
         YqGFwu3vAUp8hg+JTT0ZN4+ANpmfL5L27QkmMBjVwzHcuBOMMzfEu3z1pwk7bXFFEzOh
         XDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CrqZz4HCKBHevfoIid5R0xxcziWD26m5PkJFhrkpgyY=;
        b=Bpu/WioAfZcJe+T4iC8DH95myNMk8usPt99cr+mvwUfM4MALzG7Yl4rLzMI7Jl/eY6
         rUF9cTPoVVGHNx/z06pinS+YcUGf6uWgDwj75LD7Qsm+/rHR9AWpII/vU72WEWgea9Xm
         jn5Ij+MhdxeNLphQVnLrpjTamenGv5jdtxgPsKD/53occbmKRgcs5k634TN0EUDJpMrg
         PPux9H3/+WnLtCtHGfdsjzc31oLZ6LNKWTjzFIw8voIsGi249utJ+FnBXwaqyAyYxlUa
         FDfq67LVd7T564lgNApz2Q1UhGstv5ECoFZo/CfOL7If+7/PV6/poGRifuincOpzgJuZ
         +b4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.14 064/164] thunderbolt: Serialize PCIe tunnel creation with PCI rescan
Date: Sun, 22 Apr 2018 15:52:11 +0200
Message-Id: <20180422135138.066215637@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454987127577540?=
X-GMAIL-MSGID: =?utf-8?q?1598455516356905592?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit a03e828915c00ed0ea5aa40647c81472cfa7a984 upstream.

We need to make sure a new PCIe tunnel is not created in a middle of
previous PCI rescan because otherwise the rescan code might find too
much and fail to reconfigure devices properly. This is important when
native PCIe hotplug is used. In BIOS assisted hotplug there should be no
such issue.

Fixes: f67cf491175a ("thunderbolt: Add support for Internal Connection Manager (ICM)")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thunderbolt/switch.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -716,6 +716,13 @@ static int tb_switch_set_authorized(stru
 	if (sw->authorized)
 		goto unlock;
 
+	/*
+	 * Make sure there is no PCIe rescan ongoing when a new PCIe
+	 * tunnel is created. Otherwise the PCIe rescan code might find
+	 * the new tunnel too early.
+	 */
+	pci_lock_rescan_remove();
+
 	switch (val) {
 	/* Approve switch */
 	case 1:
@@ -735,6 +742,8 @@ static int tb_switch_set_authorized(stru
 		break;
 	}
 
+	pci_unlock_rescan_remove();
+
 	if (!ret) {
 		sw->authorized = val;
 		/* Notify status change to the userspace */
