Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo8pkIAXIX5NeggDASbvnO5IxlZnu9LVXygQS26OU4hTHJpDRiex7c577Xd+BXQ3SHdCkhX
ARC-Seal: i=1; a=rsa-sha256; t=1527156158; cv=none;
        d=google.com; s=arc-20160816;
        b=pkPwAN887bAU9QuMwfoOVkbLI6wmnxSd2NCBqDadmVynUbx1Tzq3ZXxiQBvOB/OpV6
         X0CUenBFx0P1pQbus1GpX0RiLrPUmWS4rVZuagADBG7e6TAGbpQA6AChCSEJ45m5U9F7
         q7dE/SEM43puxbwJD356hv8Yr4BJ8JYa2vfLD4ZTuaqwApEION6dI530IxT5s3iXxWCi
         t96yBL6bksZRevnJb/ENGkKz153HMT/+XYNu3KtsucD2McdOgKPPqCOwGZO7FTHUBgpn
         vGyWlzjETcu4hHaAVzyn8/RqWIEW9ZIA9TDIMX5sfYQBkVITPKarg2aJY5eR3Z4gjOD1
         txiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=0mXDSZBTtYOmqpKIXj+v392COcqYWwF0ShjztECMpuY=;
        b=qRv4opHjXMpBYbk7QpvpOPUxXZrnzKMuXalKV8Wn861vAekI2Mkq1PKsjy3bUn4XDH
         ComsCIHBXRvSvtux0wR7mUUI7/6y2Em60AZic8/QO1RmTs+oBsshKMviA3drqgDGTXYf
         ah1pvWI+l41DPchiUYwVWKErXWc6iE+0XsN5yIcU95EY7kWSDPVQ+RoAWhGocwcZrEf1
         aCk0BRf+FueCXHWgK0cLM6wX7/MxkOuED5eAY9rwbHgVFHpVXlLxQhrT6azY5sSyawsG
         /kEFg/aQqHCSUQ95BGj86syC+7TyfXHKp4p0vhTAfb0753hvC2PT/oSm8eJHKfzOd3Zc
         siUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dJ/rxFyz;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dJ/rxFyz;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 084/161] xhci: Show what USB release number the xHC supports from protocol capablity
Date: Thu, 24 May 2018 11:38:29 +0200
Message-Id: <20180524093028.551719646@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338910140685754?=
X-GMAIL-MSGID: =?utf-8?q?1601339295598572583?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 0ee78c101425aae681c631ba59c6ac7f44b1d83a ]

xhci driver displays the supported xHC USB revision in a message during
driver load:

"Host supports USB 3.1 Enhanced SuperSpeed"

Get the USB minor revision number from the xhci protocol capability.
This will show the correct supported revisions for new USB 3.2 and later
hosts

Don't rely on the SBRN (serial bus revision number) register, it's often
showing 0x30 (USB3.0) for hosts that support USB 3.1

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4769,6 +4769,7 @@ int xhci_gen_setup(struct usb_hcd *hcd,
 	 * quirks
 	 */
 	struct device		*dev = hcd->self.sysdev;
+	unsigned int		minor_rev;
 	int			retval;
 
 	/* Accept arbitrarily long scatter-gather lists */
@@ -4796,12 +4797,19 @@ int xhci_gen_setup(struct usb_hcd *hcd,
 		 */
 		hcd->has_tt = 1;
 	} else {
-		/* Some 3.1 hosts return sbrn 0x30, can't rely on sbrn alone */
-		if (xhci->sbrn == 0x31 || xhci->usb3_rhub.min_rev >= 1) {
-			xhci_info(xhci, "Host supports USB 3.1 Enhanced SuperSpeed\n");
+		/*
+		 * Some 3.1 hosts return sbrn 0x30, use xhci supported protocol
+		 * minor revision instead of sbrn
+		 */
+		minor_rev = xhci->usb3_rhub.min_rev;
+		if (minor_rev) {
 			hcd->speed = HCD_USB31;
 			hcd->self.root_hub->speed = USB_SPEED_SUPER_PLUS;
 		}
+		xhci_info(xhci, "Host supports USB 3.%x %s SuperSpeed\n",
+			  minor_rev,
+			  minor_rev ? "Enhanced" : "");
+
 		/* xHCI private pointer was set in xhci_pci_probe for the second
 		 * registered roothub.
 		 */
