Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49n7aMFGTLZ1SZN4nmYo+5keb9HQzAoGNNpLG5LwptFeGmweNkcZgsWmg7OoYpnH6H+V+j3
ARC-Seal: i=1; a=rsa-sha256; t=1523472754; cv=none;
        d=google.com; s=arc-20160816;
        b=YQhQHlwIhZdWvI5F2Ho1CiwTiL0TqVb9qwb7qboKROYbapbPBJ/bNBQQF0taxq8GAv
         L7nGmGj3stwcKjnUzShrNbnsWx9lL2RO0ur6Ge6XBgTqM3TrX3MF0rsH49+X94uy+bOp
         5o0lYUjXWyt29WoidysFahMUu9jccHvdCXpvlkELSorNjczQnpwVcY9uKLJ5Ov6kh0nq
         VMlCRJQ8F+eYY+qx6B6L7I5GvsuJMWAJ0WXXdUXU88qRVPatDiNAZ9ODQJCA1qO+dE5q
         xvIrUvGTXI1o+WBiOnjIVkzHB5QhvVC2ENM9AiYxo2PWl1i3EYrbSnTNFzBgpUPP+0wI
         ajGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+QwgCBfytT34B72Uu0W4O4wKXZ1nS4d2l1ItDYGhuik=;
        b=QcS6x4pUZltOpN+tGwsGctJr/MbOM7t6JNPtoJbpe8ENKXf8nqV723BsXz/6EM9FjJ
         VK6KNRw7zKWRU9VuKQENIHLBn/DOVv2cvscmP5JoMOt8ypC31J4rAc/WTwzEtPIBaV72
         zqmwy2R6Fibeyu4D1yNkXQzOoPPYARAYc7WU3Ep3dNRgEmXi12EdDAdA40ivhhNbzWZM
         LQSWWbJ+JA/xZKLymTnUqoXgl4wMA95Y+7v40rqEguz2le6/dl3p6ktGh1YbyiNgMMwD
         t+L5zjQIXjJQZBubK5NH5ZkeFB8iXwyDq9YIhJNn42kluk7eFajtk7binwz9LkbYeLrk
         ak8w==
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
Subject: [PATCH 4.4 180/190] net: fool proof dev_valid_name()
Date: Wed, 11 Apr 2018 20:37:06 +0200
Message-Id: <20180411183603.950690579@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476357731953157?=
X-GMAIL-MSGID: =?utf-8?q?1597476967042328822?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -989,7 +989,7 @@ bool dev_valid_name(const char *name)
 {
 	if (*name == '\0')
 		return false;
-	if (strlen(name) >= IFNAMSIZ)
+	if (strnlen(name, IFNAMSIZ) == IFNAMSIZ)
 		return false;
 	if (!strcmp(name, ".") || !strcmp(name, ".."))
 		return false;
