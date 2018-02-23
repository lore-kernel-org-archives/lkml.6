Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtExIc39Jn7h2GFOKHOtR34tb8EDl51gcGHg+LPgjbRcXKfn9V6sTk5BeJiPb2EOqFHZt4n
ARC-Seal: i=1; a=rsa-sha256; t=1519412095; cv=none;
        d=google.com; s=arc-20160816;
        b=RepdocxY1yhy4hB18Hvpoeops9ZhUExspzouwstYhcetUR8XYFogQdmddbl8w8VpJh
         iQ5mf9nufa8nJxy86RD99CWj2IMfmoWoax/z51b0FSH2ReNX5XrDSw/xLxFyraTt5sr3
         RI4ek+VSv0ZrKDl74tmo17FcZCGgeRipkyKP4X4cQfas6XV5AOnD9d3aM5NkH0EegVM2
         3JPr4Drkc86vpHfS1ibhfCqfob+Yet0cCXxj6jdwCQr432Bef0m19MBJuXrNjR8c6Yss
         Obt18ueajg21BTvp9JN7Fqv+Ct8g1MhV3TedsiZYGFoMuYQUMijBKYtoPJfbfZraisTe
         f2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bHR0qXj9IF4DaMJMzIZ0EGgwTZZIyXytfCefvqvT5ok=;
        b=uV5NbYtLHT7y3NZZzfFDpLW6wTkqoRIKt6XpWZONsWrQY6ieZldugIs5G46RHJv3y2
         kJGqYfjJoobpWdU2ZsEqaHalVVd64U7+OhuoP28UOc7fgBIGqKUU4TtvnQcEWWRurG/1
         xOq83CN/Ua2w/bXMbSJyv0k6Jr9sCcHaDhS5rBQuPm4q1c3fZRSpLaaYHF81q/YnNmwG
         QauJrjS9df0pAmoH5gQ6uDXoxatyUQsf6F4TK+ErQd2IR1IN8aJ1e0TJhKe8r09csqMc
         FOzv+/o05XadtvuU1d6imc7EYOS4O2JFAjj99jvBFq4kU8qB+qwFq93/qWLPGChdRaEx
         0/Ng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 124/159] net: dsa: mv88e6xxx: Fix interrupt masking on removal
Date: Fri, 23 Feb 2018 19:27:12 +0100
Message-Id: <20180223170758.219733834@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219057395336008?=
X-GMAIL-MSGID: =?utf-8?q?1593219057395336008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>


[ Upstream commit 3d5fdba1842bdd2eef29364c660558cb4cbb3fe0 ]

When removing the interrupt handling code, we should mask the
generation of interrupts. The code however unmasked all
interrupts. This can then cause a new interrupt. We then get into a
deadlock where the interrupt thread is waiting to run, and the code
continues, trying to remove the interrupt handler, which means waiting
for the thread to complete. On a UP machine this deadlocks.

Fix so we really mask interrupts in the hardware. The same error is
made in the error path when install the interrupt handling code.

Fixes: 3460a5770ce9 ("net: dsa: mv88e6xxx: Mask g1 interrupts and free interrupt")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -339,7 +339,7 @@ static void mv88e6xxx_g1_irq_free(struct
 	u16 mask;
 
 	mv88e6xxx_g1_read(chip, MV88E6XXX_G1_CTL1, &mask);
-	mask |= GENMASK(chip->g1_irq.nirqs, 0);
+	mask &= ~GENMASK(chip->g1_irq.nirqs, 0);
 	mv88e6xxx_g1_write(chip, MV88E6XXX_G1_CTL1, mask);
 
 	free_irq(chip->irq, chip);
@@ -395,7 +395,7 @@ static int mv88e6xxx_g1_irq_setup(struct
 	return 0;
 
 out_disable:
-	mask |= GENMASK(chip->g1_irq.nirqs, 0);
+	mask &= ~GENMASK(chip->g1_irq.nirqs, 0);
 	mv88e6xxx_g1_write(chip, MV88E6XXX_G1_CTL1, mask);
 
 out_mapping:
