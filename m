Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx494AoOb3UWjhOaeNcyQ+ho0cAS06Fudtv5bBY9fQmOCPJV4/n/sUqzN8f8t5ESptYcaRr0I
ARC-Seal: i=1; a=rsa-sha256; t=1523472173; cv=none;
        d=google.com; s=arc-20160816;
        b=F2cNJADxCO+HylfbeAmFxk/tl7lTQR/xNV/41VUkJZS8uMk2Zr8dtkEdTT47dqIA9q
         rkSH5CaT6MYydb7BLBS3gVhpMad47egp52d5pFzuAK7E0XByKElC/7lNK/1xMDmnLJHt
         00dL7HjBJ2dkNiWn58a77dqcWTSMD0gwx60OtJmmgrJEwAhhgP+Jq12y46j73VnbOa88
         9d+c8m37lT2kysal/hJZ3WVi4TXydadSIyQtkKDGfXoDUXphqSH5EIysv6SYQiwo9LcN
         twrHkJbBC97agTEyk+Ru8ve6EUJfrRd0m31h9JdY+tk5KjE8EyAEQWKF1lWNeRYKgaZ3
         Xa/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LMgue7PdIVP2Jm0aPxBb5KzEiyMxE+PI465WSAJMtsM=;
        b=uJympDjk+tDvyGCMIL7RNhcPpfWOoB38cZ//yZcAXaIhwKqkRHBmhgtDcVtKHiGBLP
         B+Vfo/jQnnK6+LkV8evZyg3WjQLRiTnPk98CQt5eqP42+CquKkqiholEBSWSh08o/5m9
         woX+e1tSq6DMvjMxaAhE2p4cdVxfhv4HCgkh+BiIs7/kyAg0R3VUf4QeM+eSxwGAVKgK
         2QdBXBPDA4PTptS7eTxN4wPJg/kkIjWw5EVYkXzBzlmdokczZ6KWrfvulbgNrCTt223e
         waAdk+sNATtQBn8FEQ2RDHxxHtlv8ilMODvczMopT8oWdVzMQ3xp/8J1q/h9CQkoOC5+
         ZqgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 113/121] net: fool proof dev_valid_name()
Date: Wed, 11 Apr 2018 20:36:56 +0200
Message-Id: <20180411183503.811542999@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476357731953157?=
X-GMAIL-MSGID: =?utf-8?q?1597476357731953157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit a9d48205d0aedda021fc3728972a9e9934c2b9de ]

We want to use dev_valid_name() to validate tunnel names,
so better use strnlen(name, IFNAMSIZ) than strlen(name) to make
sure to not upset KASAN.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -937,7 +937,7 @@ bool dev_valid_name(const char *name)
 {
 	if (*name == '\0')
 		return false;
-	if (strlen(name) >= IFNAMSIZ)
+	if (strnlen(name, IFNAMSIZ) == IFNAMSIZ)
 		return false;
 	if (!strcmp(name, ".") || !strcmp(name, ".."))
 		return false;
