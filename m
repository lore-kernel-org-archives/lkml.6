Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225oDqbyy/+NhFDMjRBLZce2PL/XMWo17dNykjkIrEkdI8mfTrPCNnn6fXTuWwnZ3/nh11y8
ARC-Seal: i=1; a=rsa-sha256; t=1517855200; cv=none;
        d=google.com; s=arc-20160816;
        b=wMj/BBN6pUVgLvX85v2MnPAgg3HM7XBeu4sqV0bv+3grB4USYCCq4gV1FhS4Kx7eeo
         A0cK+4DCHmo9JY1nEZ8daQBxb4PgZ2M6Z2DuXZbP0DkXka9cZdZtAhXNGWL7SFHDQyJq
         JhYixHkf4tvKLSjoaZrww/7zPbCpqK2FlPfeQJvt0WbwlNraRsUNMEvLX9d52hBpn9lL
         vEBtylYtnEbtOQpsfSjCdBkwUW7g9kTewLg/AqRZ0vJ2eccH/z8/yr88r3P+dH7tQImH
         Wh7PgkLwN07b6Jy1iWwQjI71NP/mPH05tkhPr4/aOoVkGCY5tGVuI0FFwic4P0xVR/2+
         FoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bMyPeGl46kaSqZ8Ipo02jGYlI+4NLQOgm6ssgctdq9o=;
        b=v9cH8Fs9ak7LugkzJ1OCrma/spq9aaxfdhsPXrgMIFD7nNg68DLasCArx8eLNQcqKc
         bLMuiDerogYVrt9+6bOdiWS5iADBAiUTv0nGjmxDqR29cELxPjzxubVwrMYT/FitHyXs
         tGTMJTAEbb+7OYltdp7PghtOXqISqRxEiXFD58U28t3raw8XFwFkxj5DajotqXy6otc0
         44NQPsswIygK1zwAQ3c3QOOIQHOuK4iW3m2CNUbz2NeleO4me3xNuHauh68Nfm0zDQJb
         TvxS4xdmmATjO6iXgogNR1XBQfmMpXuEtg2G/fxKWErTVm4PXA/XLMt2jd8wcGD8hR0v
         2asw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 23/36] usb: gadget: dont dereference g until after it has been null checked
Date: Mon,  5 Feb 2018 10:23:51 -0800
Message-Id: <20180205182352.725948225@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586534430297649?=
X-GMAIL-MSGID: =?utf-8?q?1591586534430297649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit b2fc059fa549fe6881d4c1f8d698b0f50bcd16ec ]

Avoid dereferencing pointer g until after g has been sanity null checked;
move the assignment of cdev much later when it is required into a more
local scope.

Detected by CoverityScan, CID#1222135 ("Dereference before null check")

Fixes: b785ea7ce662 ("usb: gadget: composite: fix ep->maxburst initialization")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/composite.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -103,7 +103,6 @@ int config_ep_by_speed(struct usb_gadget
 			struct usb_function *f,
 			struct usb_ep *_ep)
 {
-	struct usb_composite_dev	*cdev = get_gadget_data(g);
 	struct usb_endpoint_descriptor *chosen_desc = NULL;
 	struct usb_descriptor_header **speed_desc = NULL;
 
@@ -170,8 +169,12 @@ ep_found:
 			_ep->maxburst = comp_desc->bMaxBurst + 1;
 			break;
 		default:
-			if (comp_desc->bMaxBurst != 0)
+			if (comp_desc->bMaxBurst != 0) {
+				struct usb_composite_dev *cdev;
+
+				cdev = get_gadget_data(g);
 				ERROR(cdev, "ep0 bMaxBurst must be 0\n");
+			}
 			_ep->maxburst = 1;
 			break;
 		}
