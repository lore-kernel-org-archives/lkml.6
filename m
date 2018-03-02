Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtFQZnB+Zodspn/Mnncti+vRQXMQVIWtjePwF5UifBx8bYoi5uUD0ZsuK38MtrwIHK3b5wd
ARC-Seal: i=1; a=rsa-sha256; t=1519981480; cv=none;
        d=google.com; s=arc-20160816;
        b=dWKgnjBDLq6REpa2h1v12F1sIhMZxi3CzW/g7iu9TixYYR09nM74peLfm1SAUy71oB
         BayEmjzuUgGywwd2G5QL8ocDLVbKeuHfy8rQAkD/blufcaSoDuF1AqSrsNAhe98dPW9u
         k+0+26WvmBqIZm8feLx7tJdRaeCARyJ0RdtRj6RomekaSPB2aSxKjtNhyNHxw3SRav68
         pGC1Xleqtgc7PH27QhIninFVWq4Iv3YjtWu4dcRytTgzoVq6RoOeSJbbw0p6/Kw+kVkF
         guGDJKrlbSafIquS0lp8UfMpEo4u50K5I4b0AlOel7Uguvtj4JqSePxClBRjPOa9egtu
         m1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rOkl0bLI1zR9kZn63QPXeK2YG4H+IbepE04KFMXk1GM=;
        b=lEmlbqE69qQlqBmd7kvywWcos8LuzS2O0QXZ8gtxsYA6IN4OT8MPC9vDLQfKEgtJl5
         o/qfx8x4cjRhmemlCLRFLhtEgVGA78EEfxh28evacxm92PyQp5Yh6Bqvht4BP/bRdRc0
         OB/0+J0/jWYrzE7Q1/QUIpcRB2nADd8yJYM7j9WWATRML3Oq8aQ+k/GkWBq4qNc3kreY
         ZkLlZMvKNzB4UmzgNRsGmQAZcvoj5i1lg5gV4bW0Gb6frZUXkB9vVzauLUpdIrelF7Gy
         wbXYfwCtMPrnAVa2ptO4C4AW8G5kMzwWwntt5PbZ0+HppD7sHTN/kCmPjdizIO8t15An
         nrJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 059/115] tg3: Enable PHY reset in MTU change path for 5720
Date: Fri,  2 Mar 2018 09:51:02 +0100
Message-Id: <20180302084506.271255648@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815277327871524?=
X-GMAIL-MSGID: =?utf-8?q?1593816101164936264?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Siva Reddy Kallam <siva.kallam@broadcom.com>


[ Upstream commit e60ee41aaf898584205a6af5c996860d0fe6a836 ]

A customer noticed RX path hang when MTU is changed on the fly while
running heavy traffic with NCSI enabled for 5717 and 5719. Since 5720
belongs to same ASIC family, we observed same issue and same fix
could solve this problem for 5720.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/tg3.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -14239,7 +14239,8 @@ static int tg3_change_mtu(struct net_dev
 	 */
 	if (tg3_asic_rev(tp) == ASIC_REV_57766 ||
 	    tg3_asic_rev(tp) == ASIC_REV_5717 ||
-	    tg3_asic_rev(tp) == ASIC_REV_5719)
+	    tg3_asic_rev(tp) == ASIC_REV_5719 ||
+	    tg3_asic_rev(tp) == ASIC_REV_5720)
 		reset_phy = true;
 
 	err = tg3_restart_hw(tp, reset_phy);
