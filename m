Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224O2KZ/4a9qeB8pfjVD8ZMxaazB5W9XOrGoEs0AF1g+CeW4jUtrrm+o6XcHzgzPDPddIeTF
ARC-Seal: i=1; a=rsa-sha256; t=1519412316; cv=none;
        d=google.com; s=arc-20160816;
        b=pfW/oGf0vyjAPCj1DXuwGejn1UbcWVU1Kphw0hUnk2Ls0iHgsfoa2OivkCbDdB1Y+8
         oFanlOqOun0CIG87hzu8cKIDj5+8U7xNqZ0MvVvHTH57uF+I+/OjpQWoqBN3Z8Rx2kN2
         +QYO+Scigy1U9wNx0ZUJYE0qMaYR222AhEUq+fY7EYPY7KV0MNWlo/qG1u9f9ycDfmzY
         b216TWPsgb+uCBvMl4/BJpPmytsPH1SjVMZzlCNtA3FpithGycx1UDrSY1sAad8dmKec
         N1EUYeX1L9UxLN6JFcRdu80TzPGuydkF5hOTePSmS4pYQUvoOkPLedpTI022IYEJxBH2
         MOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fIvJkW7iGp+iu29yXpmSOyI94f70L7BFzTv/3QhcV8w=;
        b=PY2jDgcm6Y0bOSResWQCSJNPbfSxaz3o4ygy7xN02K4GcjzuNSPvI0TKfLxMAEattq
         XOYVk/3lKmosJm+ywf/tywts7BAz+fHob5Bcp1r63FblgL0MlzYFB8RPRIyVYuJ5Z7pA
         ai08YIfg9AwbD+AurWgv2V25mixpo7X6nCCx59ygu5GBr7GQhH1upvSrwwPHgzblZJ37
         FDlesbiHudMfeAI5OfkR4+fTpdGXcUupLDCnPDvSegURTagYzY6+TSZgOZsSX8WLXQT2
         SkLZLuAWialAzL872LBi8EHjV/aOB2fujBsJjuKFQb4ZWdR/G4tx+EdizL+QI4tZFaTz
         cstw==
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
Subject: [PATCH 4.15 38/45] xhci: Fix xhci debugfs devices node disappearance after hibernation
Date: Fri, 23 Feb 2018 19:29:17 +0100
Message-Id: <20180223170721.370977939@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219289454771087?=
X-GMAIL-MSGID: =?utf-8?q?1593219289454771087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

commit d91676717261578f429d3577dbe9154b26e8abf7 upstream.

During system resume from hibernation, xhci host is reset, all the
nodes in devices folder are removed in xhci_mem_cleanup function.
Later nodes in /sys/kernel/debug/usb/xhci/* are created again in
function xhci_run, but the nodes already exist, so the nodes still
keep the old ones, finally device nodes in xhci debugfs folder
/sys/kernel/debug/usb/xhci/*/devices/* are disappeared.

This fix removed xhci debugfs nodes before the nodes are re-created,
so all the nodes in xhci debugfs can be re-created successfully.

Fixes: 02b6fdc2a153 ("usb: xhci: Add debugfs interface for xHCI driver")
Cc: <stable@vger.kernel.org> # v4.15
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1018,6 +1018,7 @@ int xhci_resume(struct xhci_hcd *xhci, b
 
 		xhci_dbg(xhci, "cleaning up memory\n");
 		xhci_mem_cleanup(xhci);
+		xhci_debugfs_exit(xhci);
 		xhci_dbg(xhci, "xhci_stop completed - status = %x\n",
 			    readl(&xhci->op_regs->status));
 
