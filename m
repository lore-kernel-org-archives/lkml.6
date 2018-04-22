Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49mhbLRYyqf84OkAc6riQXE2sePnpD/RqHTm+q6BdynVIBVxVOLma7E0qY60kHLgZqUvj/Y
ARC-Seal: i=1; a=rsa-sha256; t=1524405475; cv=none;
        d=google.com; s=arc-20160816;
        b=HjarDWWFXgxpxut9NiqLz4MgHnZrrUU5sFjL4hI/Ff6G6z8Wm92vtvhwX//IQTe6bY
         36GSuJfsOVaC2oKOhWhi0XL3BERr4akB9j6EiHcyHvn7Xr6bsGCGk09DwYRtTGPfq5OE
         Oq2Zn6pBEMDuvePzkkXaMO4zGv5T6+wHLSfC/o2owaNfXVh2IoTDRbmPiw138MPH4sbr
         xJ2QJy+mzNz8mWTXKe+E7USmvjuJaw5NXsygKknImWr4IT2tMIiYo9AVozs1QjOu7N9x
         oacOjBzQAg+l680ZITPDo66StOKxD7PYoC0+WUkGC+s+8nclS3bCOdoSnYUNCaLr9lPx
         5S3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zG0zLxCVwtMSzOXDDStKZvzga7myATr7BsYO0l1RvaM=;
        b=t/tIKcfC6eFg6t0l4m2eRGTiFyrYdW/Q/W3Rt17ubEi1KZ9Z66RY1+BZQ0p0AHm75P
         AJP0Mdc7BmG2fVRreN//7StOhQCa//bwGp6tTuul1yBlt8Zd3FBdA2rWBOsEnBIliNRw
         a1Wd80ezlrqQrG9sc19EsiYPisbgVGcp4c0fDESHC/6ItTxIp3LeWhwDLMm4rQYOVlDQ
         Rwq6IlbgT6FM2HYR/vOC9f1/rNSQvO0UuhJvGNkx8gosw/hanixNKL2hQjPpS79UeGh6
         /KQQpO2lsXA5IbFnN5mgu0tACVo9wflWgOQN+XeDbrBpstl1Xugv2wrykLX5uPSv/w2R
         7/nQ==
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
Subject: [PATCH 4.16 079/196] thunderbolt: Prevent crash when ICM firmware is not running
Date: Sun, 22 Apr 2018 15:51:39 +0200
Message-Id: <20180422135108.378667088@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454995914765276?=
X-GMAIL-MSGID: =?utf-8?q?1598454995914765276?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -923,6 +923,9 @@ static int icm_firmware_reset(struct tb
 	struct icm *icm = tb_priv(tb);
 	u32 val;
 
+	if (!icm->upstream_port)
+		return -ENODEV;
+
 	/* Put ARC to wait for CIO reset event to happen */
 	val = ioread32(nhi->iobase + REG_FW_STS);
 	val |= REG_FW_STS_CIO_RESET_REQ;
