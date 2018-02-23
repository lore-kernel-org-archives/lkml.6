Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224hav+XE15QYYuhFNcJyn1ricIKcaWFplDkXXu3QhuVhQdOFkkGD9kyBmSZp53/bXxc+KVN
ARC-Seal: i=1; a=rsa-sha256; t=1519412019; cv=none;
        d=google.com; s=arc-20160816;
        b=gK5a5aeObMpZ+ViuZXfJPuxctc63g2Iygz8bWnh9Q1QsK1+f7Ftl51b5IlS1W/l8rg
         7EFxJXr6DsSJTRtp6wSD1mGgnEyPnonpD0inzQwgAunM84CS48o/BmoCWuXvQ6YBT9KT
         GDH1jQzqHVPVSPdDsRvMbZFDVm4gz2ZssG4yAeOiQ6Rq6aYyUwg/wlv5GL9O0SW30RbH
         SZBwdBTv1bPxogcIU6FcHQvWbpV0B+AMrT+RUwq6uXyozv4vleYQGoXbLmzjkC2mGQGU
         tIkWFHOx+7oZUqOZ5zjgodh6rl1eFBthhUYKkZFWLxbQhB1pnlT9B4sYjT57cXZZ357Y
         MbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CCOmxehAaXA8hxnBXbsai9nXA+kWnhmoZ4KrO0M/7do=;
        b=ky74pp8wNXC4Qprm7gIOPOhp0fs2Qr8Ch4kaL7/xTbUrtIjMZ8DOEf7likn4LLihSu
         ljHckG2XCIzXetH2Ka2ArbPONem8WrAauCEl02olYwfUy/6D8EzdIyPjT1yoCC68M9fh
         5bIoi4YDLOetzGA5z1oldfw2Nipz1ocTocwy4s0+ywzx9r0Bgq8kq0VpGDNobvy8V/8r
         XK9G0N6gD5d/z0WB6Jyt/8letjHZTwM86qqPhz2yqwKQcz6DHw2APfpMjAMfFmwIaeUC
         s2ccNliipofhP2plp+MoXwYkxf01EHQORPI15JexAxmuXkOHu102mG7fNNLznwKmjmuz
         /TcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 096/159] sfp: fix RX_LOS signal handling
Date: Fri, 23 Feb 2018 19:26:44 +0100
Message-Id: <20180223170755.130238598@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218977972201938?=
X-GMAIL-MSGID: =?utf-8?q?1593218977972201938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>


[ Upstream commit acf1c02f023926b8b04672a9e81b1711ae681619 ]

The options word is a be16 quantity, so we need to test the flags
having converted the endian-ness.  Convert the flag bits to be16,
which can be optimised by the compiler, rather than converting a
variable at runtime.

Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/sfp.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -358,7 +358,7 @@ static void sfp_sm_link_check_los(struct
 	 * SFP_OPTIONS_LOS_NORMAL are set?  For now, we assume
 	 * the same as SFP_OPTIONS_LOS_NORMAL set.
 	 */
-	if (sfp->id.ext.options & SFP_OPTIONS_LOS_INVERTED)
+	if (sfp->id.ext.options & cpu_to_be16(SFP_OPTIONS_LOS_INVERTED))
 		los ^= SFP_F_LOS;
 
 	if (los)
@@ -583,7 +583,8 @@ static void sfp_sm_event(struct sfp *sfp
 		if (event == SFP_E_TX_FAULT)
 			sfp_sm_fault(sfp, true);
 		else if (event ==
-			 (sfp->id.ext.options & SFP_OPTIONS_LOS_INVERTED ?
+			 (sfp->id.ext.options &
+			  cpu_to_be16(SFP_OPTIONS_LOS_INVERTED) ?
 			  SFP_E_LOS_HIGH : SFP_E_LOS_LOW))
 			sfp_sm_link_up(sfp);
 		break;
@@ -593,7 +594,8 @@ static void sfp_sm_event(struct sfp *sfp
 			sfp_sm_link_down(sfp);
 			sfp_sm_fault(sfp, true);
 		} else if (event ==
-			   (sfp->id.ext.options & SFP_OPTIONS_LOS_INVERTED ?
+			   (sfp->id.ext.options &
+			    cpu_to_be16(SFP_OPTIONS_LOS_INVERTED) ?
 			    SFP_E_LOS_LOW : SFP_E_LOS_HIGH)) {
 			sfp_sm_link_down(sfp);
 			sfp_sm_next(sfp, SFP_S_WAIT_LOS, 0);
