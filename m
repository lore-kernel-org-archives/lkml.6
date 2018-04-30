Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpTkWE3WAVTV8qVHuJQbJnRPZmuVajRrxvrhnPN8CwwG3jc3V4Ypnv9oh9mqF+mVkRI9lwW
ARC-Seal: i=1; a=rsa-sha256; t=1525116418; cv=none;
        d=google.com; s=arc-20160816;
        b=Cx/HNR0zvxl0Tgj25804Ctl3UeyG+Ek9TucL2bjsHuix8HT+1aL4YuOwcZX4SSqFwp
         K6dC1HuAk5hWALveHdY8ZD/1iuJM1On1T+E/fxMSvGRtaDDg+O3v82DkGxevTwIXQUiP
         m29A1GM+Hab/8sq/F4VXr0FRAd+bBYw5aLWgQg/msUVAgf46MuKKhXWnCfS9wwhaQhPi
         LLQdQuLAhzMPOiE3euyemWoPZV3yICCy/7nwJpx33KjlsJoOzpIXcjHZxyYcBQouC9UJ
         KI+67eBFaCikZiA9WRpEHkzhAntW1Xmqo4UxUuwxI3QDLPL086WbgyqKw2CsQBlwkL8w
         HjRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=VnCpcWlkk640TfkVD3xIf/xtL+17+RWvZ3KUvsU2pco=;
        b=XxqToG+xzlQiDTZ5dRqpOvfTZtPjXin+uM0zGxJLH1wgCAnaA/zfxG5F0K+8kPXLVu
         07fQrNYVZzM/mZX0B9mpbu0Tc0hVK0NIJnwqWIjrOIV3Z9plnjcSh6eSVGxgdFb87uGd
         FelxcUjq3v6nEdcniPeKgOA9+Q1rpM2PM8Gdn6G7irHanY7nDn+rMpkjvNVz0Oz5KQO5
         kERyc8kD9JG8oSKDS6LNCHdw/ICj5DSIb1DBvOTbV6JUMwwq9DKc/+Jll00MDC+Q9xcw
         G09RWX5ngLKWY9By0zBVCKqLA4VI85PzQNfWB7CeksHtMo7VXVobCCXHMbVVARfScOnp
         r6EA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC2722DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.14 14/91] xhci: Fix USB ports for Dell Inspiron 5775
Date: Mon, 30 Apr 2018 12:23:56 -0700
Message-Id: <20180430184004.957200675@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200473674705652?=
X-GMAIL-MSGID: =?utf-8?q?1599200473674705652?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 621faf4f6a181b6e012c1d1865213f36f4159b7f upstream.

The Dell Inspiron 5775 is a Raven Ridge. The Enable Slot command timed
out when a USB device gets plugged:
[ 212.156326] xhci_hcd 0000:03:00.3: Error while assigning device slot ID
[ 212.156340] xhci_hcd 0000:03:00.3: Max number of devices this xHCI host supports is 64.
[ 212.156348] usb usb2-port3: couldn't allocate usb_device

AMD suggests that a delay before xHC suspends can fix the issue.

I can confirm it fixes the issue, so use the suspend delay quirk for
Raven Ridge's xHC.

Cc: stable@vger.kernel.org
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-pci.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -134,7 +134,10 @@ static void xhci_pci_quirks(struct devic
 	if (pdev->vendor == PCI_VENDOR_ID_AMD && usb_amd_find_chipset_info())
 		xhci->quirks |= XHCI_AMD_PLL_FIX;
 
-	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x43bb)
+	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
+		(pdev->device == 0x15e0 ||
+		 pdev->device == 0x15e1 ||
+		 pdev->device == 0x43bb))
 		xhci->quirks |= XHCI_SUSPEND_DELAY;
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD)
