Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49SpI6KAYUiOT6B4w01SS+hMp9dTKIplud6h7u74lTRfMpjyA24r0MpHYtgS5D/UgiGbs1W
ARC-Seal: i=1; a=rsa-sha256; t=1524406821; cv=none;
        d=google.com; s=arc-20160816;
        b=Q6Ds+d5I6Bu7m0URovFsQfmpgCT4sCaPgttP7xMftGgPe15GjndbdKZ6ovHBayZA8J
         you2KpPQF/YM2cuKWJecqqTLV9tL3z5sneGiwUCf5XNcUxnQ8BzxwavxN6Otpq00KQQP
         z2vKETlD1uq7jI2ai33Yrs5Q1XtVxwmsyvEO/4Tf+m+ar60o21srOhkb8iCrjIUA8hTE
         fSyNkrUEJM1ZEb7fm2aptlrut6JwDRJ7syKj8Ue81+21sAjxkTYebp52PcL4wwHDWXCt
         Wsgv+AapNXpjcs0UQ38tFIXyZYE6UFLKwdcOkVXxUBKORxdD7d+2UUlYF848LmhDwWmO
         exHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Jj4pwqqKi8oAl0pDygXGsFFrpaAiQg7TYNBw006JOBU=;
        b=wl+9SMZ+0R9LyCKuucBhnwu7OD8GHdYR0FDe3ZXMFS83OWOhF4no3PeS6SAN1BsmB7
         mVHn7JiBAQrnjtqKdXm9tHfjKzXcUfZP4FPi97V5+PrBy+vPlzR2PoWAFCct34hcxlKO
         Vuoq25C+PZP3G9MldFPy/2wYXS3VmaHRhhwllehy3PEvsrIj04Q9cXjbUfQ+vvcZxHCV
         2947PTlVMDvM298K2X9CshYdATicsHESavU+vvLEMGd5Stzs5c7uqb5GpsPRb/q4QccJ
         tr9ztKEvw4ngrGNxJvhsv+EdlO2Uc/eZ4r8jcqAxNs3eXRgyAbCbzAsyMiFf1IQFt58l
         rfbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thinh Nguyen <thinhn@synopsys.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 3.18 17/52] usb: dwc3: pci: Properly cleanup resource
Date: Sun, 22 Apr 2018 15:53:50 +0200
Message-Id: <20180422135316.067084196@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454910876862386?=
X-GMAIL-MSGID: =?utf-8?q?1598456406701238834?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit cabdf83dadfb3d83eec31e0f0638a92dbd716435 upstream.

Platform device is allocated before adding resources. Make sure to
properly cleanup on error case.

Cc: <stable@vger.kernel.org>
Fixes: f1c7e7108109 ("usb: dwc3: convert to pcim_enable_device()")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/dwc3-pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -143,7 +143,7 @@ static int dwc3_pci_probe(struct pci_dev
 	ret = platform_device_add_resources(dwc3, res, ARRAY_SIZE(res));
 	if (ret) {
 		dev_err(dev, "couldn't add resources to dwc3 device\n");
-		return ret;
+		goto err3;
 	}
 
 	pci_set_drvdata(pci, glue);
