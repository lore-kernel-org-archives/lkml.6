Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsoL8wz8fMT6pcy8JiCKyFH8nctDukC5d5ICm9J9OULCVaZ3BDm8St5Qj66Aub3NKnzQLD7
ARC-Seal: i=1; a=rsa-sha256; t=1521214791; cv=none;
        d=google.com; s=arc-20160816;
        b=umOFRCKWZtQEzDZ5CQk2QHCgNyY2fQJNn6sL3CjFMXM8xAWUBamWjp5tSIMCMtr3dN
         LdEm7SS7xCmmfakMr3gqtHFqY0A7tiHr0iZ1hyBlLRWC8fbPA7CpQgnVwIoyiIM8u0mQ
         82wbF9aT/pqVXC9OugPw58ousaalNH7mF5NiJhjQ7vK1h3yM3/q7Q45annFhUTIjsXbv
         LULBLoZeTMnHBBW/oaEnAJF5J/Y3zSO9xu7HVvutuCoVwIumMR5CVoLgwmB5LDXZfqYN
         CzrDN1eUJQZp2I4F53uiA4qa3vW3/SBeO9QnfQmPJVMRAy+vFnBR30tOyDodIJFhMjBV
         yUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kSEvqDJ2FBTYjKaVT2oCCfb9/jIvcIpFw39UuTdVgUU=;
        b=pvG04OsAqjFRIkNCxxs6arDxyM12nVHtadEGnBDixMw3H2yUoIU7rxBAeoEsGxeDdu
         7IN23eKlgqCS0y+KgAewD9HyltGSLI/8FUS0Bju1GF6hOlQr2ekDqq0cm7yGwSkT7wby
         QQt+yKzNuzcj26ij/7P9hl+mA5ue01lTQP+FBQNjrOXO21bA0ehT0kWcfharsAYutzi5
         vW7Q0uthNWzC033rmdCfSlSl61+y/8IAkNvgs8fcvqAFJJh22dcDCC4Hq4Uhcck7/je/
         jOIKs/SIHKON28HqopYRsHI2DLnq46YP1OJm4r4ouP8LSBx6o5C8QchTmJA/wjjZnhZz
         FZ+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Manu Gautam <mgautam@codeaurora.org>,
	Roger Quadros <rogerq@ti.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.15 020/128] usb: dwc3: Fix lock-up on ID change during system suspend/resume
Date: Fri, 16 Mar 2018 16:22:41 +0100
Message-Id: <20180316152337.461671666@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108994871976888?=
X-GMAIL-MSGID: =?utf-8?q?1595109321864947929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Quadros <rogerq@ti.com>

commit 084a804e01205bcd74cd0849bc72cb5c88f8e648 upstream.

To reproduce the lock up do the following
- connect otg host adapter and a USB device to the dual-role port
so that it is in host mode.
- suspend to mem.
- disconnect otg adapter.
- resume the system.

If we call dwc3_host_exit() before tasks are thawed
xhci_plat_remove() seems to lock up at the second usb_remove_hcd() call.

To work around this we queue the _dwc3_set_mode() work on
the system_freezable_wq.

Fixes: 41ce1456e1db ("usb: dwc3: core: make dwc3_set_mode() work properly")
Cc: <stable@vger.kernel.org> # v4.12+
Suggested-by: Manu Gautam <mgautam@codeaurora.org>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -174,7 +174,7 @@ void dwc3_set_mode(struct dwc3 *dwc, u32
 	dwc->desired_dr_role = mode;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	queue_work(system_power_efficient_wq, &dwc->drd_work);
+	queue_work(system_freezable_wq, &dwc->drd_work);
 }
 
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
