Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr6LW6IHxbCQauW9CDTq/gbtCQBjeZ9WXVrkPIQboxcp5sPKFfGG87wcScCf3zxP4Mf5X6J
ARC-Seal: i=1; a=rsa-sha256; t=1526631544; cv=none;
        d=google.com; s=arc-20160816;
        b=EQGANjTDzjaaX5ezdfSOo0QVIb9O46jy+7bbZodpGH6Mgl9vYGWNTPR8dDIfpsClWZ
         qpyQLbIxRwTV7kRN3cfXfX8DcShk75kkbv8TTF5Ihqz2YWVBIRDpQMEPR38LGg7KrCnF
         0w1UIRbHqrclDsXJRS5CAACvZtLid/nbpNtYl8Qcy+8N7V3QV1iPmExgIy7Y4YQyVaqW
         j8FH32iiHnh2pgh4EOYtTPDnIF8vyJlZbOQIJMEfYP0Kr57qWzN07nJik8QLzULD2t4N
         qtcA7KmlcV+5gKT2G7/XpIi91BqGq0rj9YENqRkda1Ibttan0KACsexK0nS7nwadjOf4
         /Bpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=oahxqUhvfnjvNLlCfAc4iT3IOE0Nk8yyq+tBQLNYdcc=;
        b=eXtP+dGVnD7jeTObhOjNTXpGCl7NhKdKr5tPyh8Y8lWuW8jZ+/ipyqHKDUWVyOq6Yn
         x/yO/uVJattlCecHCaZW8Gm40C4PLP/A9kgR/c0vW5wFnS76bJ96+DGjyrSVpTPCU3FE
         t4/T1x+sQCEN5GTlG/xnRJxWqzjkN18j2tgmbMWpeFGmXW9wzRNWQxUaS639DfTqGIy5
         WipX1kcx+OIS4ulVUEgNA5RxBDENQB54/tF5PJc9AL/5ObzuFreXWcBWdwGilT4gwdVh
         14fIAzOQ10M5F4C6s/W19ecVrrKj9bmdS0F9H7IPqkfM84VjCvXp27F+4IE3P+TRQuMd
         ZKWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QFRfQ7nU;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QFRfQ7nU;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Antoine Tenart <antoine.tenart@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 52/55] net: phy: sfp: fix the BR,min computation
Date: Fri, 18 May 2018 10:15:48 +0200
Message-Id: <20180518081459.822713205@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789199246871729?=
X-GMAIL-MSGID: =?utf-8?q?1600789199246871729?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 52c5cd1bf0cecf4b146ca07dc513cbe2f4583bb5 ]

In an SFP EEPROM values can be read to get information about a given SFP
module. One of those is the bitrate, which can be determined using a
nominal bitrate in addition with min and max values (in %). The SFP code
currently compute both BR,min and BR,max values thanks to this nominal
and min,max values.

This patch fixes the BR,min computation as the min value should be
subtracted to the nominal one, not added.

Fixes: 9962acf7fb8c ("sfp: add support for 1000Base-PX and 1000Base-BX10")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/sfp-bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -190,7 +190,7 @@ void sfp_parse_support(struct sfp_bus *b
 	if (id->base.br_nominal) {
 		if (id->base.br_nominal != 255) {
 			br_nom = id->base.br_nominal * 100;
-			br_min = br_nom + id->base.br_nominal * id->ext.br_min;
+			br_min = br_nom - id->base.br_nominal * id->ext.br_min;
 			br_max = br_nom + id->base.br_nominal * id->ext.br_max;
 		} else if (id->ext.br_max) {
 			br_nom = 250 * id->ext.br_max;
