Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48xn3LQfYZOO95D0bebl+le52WxxcVxnfxLnsFcjKTj4xTzUnwKRyPgtJKsu2vAX2xinTJy
ARC-Seal: i=1; a=rsa-sha256; t=1523399054; cv=none;
        d=google.com; s=arc-20160816;
        b=Gl99lkLddKcX27rxy50qRmkKRPva80KfJrBh5mi5KiYgdmT+ke8Brw9BmO2I03MeCx
         A3hBTJwEdsSfNgict2PYjZ+Xnwdr4xAXTOy9yzV5mHdTsTnkrlOtyoUXslPwVj0miFgx
         urL/R4QME829CCjvw9SOX3QWaFef2BeEbNXakCuvSXzIFL7o10MNhADVJJZtXedwPt01
         QYY3T3VGe9fiWqBW1mqLX1Bb1gN3LWFvgsPrdDwcLbQHgbQVHFv8tPAKtGVc8q+3Ig3w
         Kk79ffLymEdCuIdPUE4ieoyf2eMZ/8mb8m0CE63hL7aVKAmz/QFaCuMb+FPSsAgRG48I
         JkvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2kLI1KA4W8u1HXdRgSmoUolsSip+tQj+cRjdG+5cxq0=;
        b=Xme0kRqwKkGXr4GEN7hRRyWAi7zdrK0hwIN2q/x6HVxbLbirQjt27ZsZgoKXf4e4NE
         DHlQG2pfqbaHrDvCw1kvOIvu8BP1QlkgJUxlSfxr/wznaYjcdi4om+tTRYFDr2vFl4at
         9iY9eikrx4uaoK9BaqGoMBK57Q3i3NfcxgqHfkYAafdZw4jDSVDOgK/3USq+mwph+aJ8
         s/lK2CJgSFqm6pp6IC/UU9aYohBg8N3kRIO6qTsp5xu3FzsmjIJZyTqZiuXAl6bJhROQ
         ku+QNp/cM3B1UExzTrW2MZTHr40zQcNsqOMnZLzh0ME9nEjxx3h1FLl1xuBCIR98Vdhn
         UK1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Healy <cphealy@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 03/18] net: dsa: Discard frames from unused ports
Date: Wed, 11 Apr 2018 00:23:38 +0200
Message-Id: <20180410212758.734898358@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212758.564682823@linuxfoundation.org>
References: <20180410212758.564682823@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399686484701021?=
X-GMAIL-MSGID: =?utf-8?q?1597399686484701021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>


[ Upstream commit fc5f33768cca7144f8d793205b229d46740d183b ]

The Marvell switches under some conditions will pass a frame to the
host with the port being the CPU port. Such frames are invalid, and
should be dropped. Not dropping them can result in a crash when
incrementing the receive statistics for an invalid port.

Reported-by: Chris Healy <cphealy@gmail.com>
Fixes: 91da11f870f0 ("net: Distributed Switch Architecture protocol support")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/dsa_priv.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -126,6 +126,7 @@ static inline struct net_device *dsa_mas
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	struct dsa_switch_tree *dst = cpu_dp->dst;
 	struct dsa_switch *ds;
+	struct dsa_port *slave_port;
 
 	if (device < 0 || device >= DSA_MAX_SWITCHES)
 		return NULL;
@@ -137,7 +138,12 @@ static inline struct net_device *dsa_mas
 	if (port < 0 || port >= ds->num_ports)
 		return NULL;
 
-	return ds->ports[port].slave;
+	slave_port = &ds->ports[port];
+
+	if (unlikely(slave_port->type != DSA_PORT_TYPE_USER))
+		return NULL;
+
+	return slave_port->slave;
 }
 
 /* port.c */
