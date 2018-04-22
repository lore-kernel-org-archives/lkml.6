Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49bgN16ukpnlz1vHL+MYi7EXUfnMzAKOBnp1b3YXa+yCz3qBoLNNSl0ZM776jiXlJla1+3y
ARC-Seal: i=1; a=rsa-sha256; t=1524405977; cv=none;
        d=google.com; s=arc-20160816;
        b=k387n0rqIADlbsNyn15L42wjRat5oFudOMw7NcUBe/NMNNHsced6PWDzOeyRWmGeax
         BxouNUt9xwFkfTy2I5Dp1QEN+B28xHlAh0QbLIbHhtHj4x2ZlNn2sQoiFgK09kVUiMha
         ibEPQJsaTciRQaiPTQZSmO7+i961rFdDkCWlp0N52A6rMn/uthZDQFac2OTKXk3Bpj4p
         7RSlKfg2bVqGnsfFet6icJu3QqWH41VvoaWkFiL1ZhxLY2eFEIw2rdkPgPi+encp7s9p
         /OycFwcawzh6GoGR4eItIOELPblN1v1xed6FYobEFVabydqZkgjP1FGfq7jifrazbngH
         oyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VrBvh/jG93QgNoAdE/oZxSHrNRzx5SZa1Hk/4hSgxVw=;
        b=HcdkVMp8mARaMOT40cFYF72Oy3yZ1+OWcJLKhiHO3OF1HSQMDKa/57GplPsWXiALIh
         7zVA9syfzZz+6b/yyeU3KdlmhARmRn0Rv8AMdtpIFmBFurH0pF59X5z3fXV/c57iPXr8
         Ue/VqJ9VXgnjDRiFwzRAR/F06PXD1BpU/yr1cVhcwcTSPm78piZqQ48BjJpGV/kK6XZ8
         upEMVAzBrRoZ2Tm4NkzeLX4g7WzeHoHDdAVHYbyqNPQxzNQcH1TfEAZGFzO4O7OhwgLe
         FzCmDLj7k0VsD0QRE41dHVa4+BmTLZYs7GVrDo/t/dyLR7VO/PRPoG6rlSFJhpo9Xbw7
         QpJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jordan Glover <Golden_Miller83@protonmail.ch>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>
Subject: [PATCH 4.14 066/164] thunderbolt: Prevent crash when ICM firmware is not running
Date: Sun, 22 Apr 2018 15:52:13 +0200
Message-Id: <20180422135138.156215374@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454995914765276?=
X-GMAIL-MSGID: =?utf-8?q?1598455521870282723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit ea9d7bb798900096f26c585957d6ad9c532417e6 upstream.

On Lenovo ThinkPad Yoga 370 (and possibly some other Lenovo models as
well) the Thunderbolt host controller sometimes comes up in such way
that the ICM firmware is not running properly. This is most likely an
issue in BIOS/firmware but as side-effect driver crashes the kernel due
to NULL pointer dereference:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000980
  IP: pci_write_config_dword+0x5/0x20
  Call Trace:
   pcie2cio_write+0x3b/0x70 [thunderbolt]
   icm_driver_ready+0x168/0x260 [thunderbolt]
   ? tb_ctl_start+0x50/0x70 [thunderbolt]
   tb_domain_add+0x73/0xf0 [thunderbolt]
   nhi_probe+0x182/0x300 [thunderbolt]
   local_pci_probe+0x42/0xa0
   ? pci_match_device+0xd9/0x100
   pci_device_probe+0x146/0x1b0
   driver_probe_device+0x315/0x480
   ...

Instead of crashing update the driver to bail out gracefully if we
encounter such situation.

Fixes: f67cf491175a ("thunderbolt: Add support for Internal Connection Manager (ICM)")
Reported-by: Jordan Glover <Golden_Miller83@protonmail.ch>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Yehezkel Bernat <yehezkel.bernat@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thunderbolt/icm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -720,6 +720,9 @@ static int icm_firmware_reset(struct tb
 	struct icm *icm = tb_priv(tb);
 	u32 val;
 
+	if (!icm->upstream_port)
+		return -ENODEV;
+
 	/* Put ARC to wait for CIO reset event to happen */
 	val = ioread32(nhi->iobase + REG_FW_STS);
 	val |= REG_FW_STS_CIO_RESET_REQ;
