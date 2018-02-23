Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsuiSIxjLHxoFq/XXXriPxUHOkBEtyLV4YT03ZCKurxPn6V29XUIG9iB0+IU/i/X58Ynnpu
ARC-Seal: i=1; a=rsa-sha256; t=1519412322; cv=none;
        d=google.com; s=arc-20160816;
        b=LM/8EA1nadPgDnUjpSSMmXFkROh8ccdCxBAIvkzF1aDNwAz8KCZIh7l0Dm296iJLhQ
         87L1r/yTudpSpOCTjiEwkyCqn4p8mcSxtYIhw2fP0xLFO+avGk1zquk/scX6Ja3hUEyr
         sEVOciDLcI72PdleEAd1Mze+qOrC6t3Z67j7KP6FTiB0duIChRViwBr0bh0acbgbPtbT
         1AIL5mP8UXDoH528c3MnV6/1j9a2f+D8utlV87LRMvynfiJuJcBiApqIVMDP9kMfns53
         0pIsfDFBtVYdnRd80pNqwgXAQK1ij1hvGS+SMPvdCHc4i56aQ7G4pjVTo6+Gyc6drRiR
         +/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IpnkShDaHW91BUgnT3yW36Ghee6BSjVFbnZPHJITC8E=;
        b=C12Ca2/Vf0x550mWojLHsn705mrjf3kuh4jPisa7mBQd/oWrR4OFMA08sL63LVTXYu
         9AH4d7K7qra8KsIDymFWoL9GlHaVwUhNwJ/v8VplOWLNj8XhzoQ2bzq80ldrg9jhoeRf
         rgoIWbWdBvIK8Gq+QnXZFvNw59B+sDgTfS/7MMUlPhEnJ+jlCnEoRtArDFeri7YTEoWp
         VjPSVoE1IL2avCgeR8RwQeG8POCQTOjyYVc+M471tqKRH7qRO+tcw0DBU3OoTYNvNQFR
         KyEfGGnB127menTvBw7+b9iQTF0tAV89DiBqQyUZOaIlbptCpmMU3dYFeNLrI5BNWwiG
         +Kmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zhengjun Xing <zhengjun.xing@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.15 40/45] xhci: fix xhci debugfs errors in xhci_stop
Date: Fri, 23 Feb 2018 19:29:19 +0100
Message-Id: <20180223170721.723267082@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219295556498276?=
X-GMAIL-MSGID: =?utf-8?q?1593219295556498276?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

commit 11cd764dc9a030991880ad4d51db93918afa5822 upstream.

In function xhci_stop, xhci_debugfs_exit called before xhci_mem_cleanup.
xhci_debugfs_exit removed the xhci debugfs root nodes, xhci_mem_cleanup
called function xhci_free_virt_devices_depth_first which in turn called
function xhci_debugfs_remove_slot.
Function xhci_debugfs_remove_slot removed the nodes for devices, the nodes
folders are sub folder of xhci debugfs.

It is unreasonable to remove xhci debugfs root folder before
xhci debugfs sub folder. Function xhci_mem_cleanup should be called
before function xhci_debugfs_exit.

Fixes: 02b6fdc2a153 ("usb: xhci: Add debugfs interface for xHCI driver")
Cc: <stable@vger.kernel.org> # v4.15
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -652,8 +652,6 @@ static void xhci_stop(struct usb_hcd *hc
 		return;
 	}
 
-	xhci_debugfs_exit(xhci);
-
 	spin_lock_irq(&xhci->lock);
 	xhci->xhc_state |= XHCI_STATE_HALTED;
 	xhci->cmd_ring_state = CMD_RING_STATE_STOPPED;
@@ -685,6 +683,7 @@ static void xhci_stop(struct usb_hcd *hc
 
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "cleaning up memory");
 	xhci_mem_cleanup(xhci);
+	xhci_debugfs_exit(xhci);
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"xhci_stop completed - status = %x",
 			readl(&xhci->op_regs->status));
