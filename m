Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsRPAqwkc9bLzkiGNosDODzy77evYmhjFyTdZ8KmD2Q4oLVjCi2g0gFsi8W7KQ5FVINigX7
ARC-Seal: i=1; a=rsa-sha256; t=1520641251; cv=none;
        d=google.com; s=arc-20160816;
        b=tlAYXgNcYgJJY4pSiwfFZHLj6DuVxZixS35ovh81wILht25+XZ4/jm47aW7YvDWDC6
         yUQEdHDVG6mrhXdEEISQYRsgy+/2t5O57dhAlm16a/TG59FmnY+v9Dx0wvExbXGMZlU+
         qk/1EsuyoUicjwu9rBg9qauRVMqv4bOUCBmzK3f+y8ynvjmc9LkfF0tf4sITIbXS9luu
         D3voYpIyB44S6MUD4htvhPYjyHcZ1VvxzEPe3OHAJUarayR6gDQYlei+sKc84JtmnJh/
         YvszRgdMBQWmPe5C2gowzI54DZkMeTyqZBkeYygCrKpCwyKMND4+T4De2jxxQU4UdAoV
         uJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yF0g3bT1DzAAGNu95QAbbkV8klCQO4U6OJLlw0MQ2nY=;
        b=syY4e8sw7cdw9tmKcTUgcpaLsH3vJPi/xEzedX820WUqtdim+mMR5RK3yEXZdYqiF3
         +oeh2tUx09hvD41utwZtypX2/WFO0Srw9sx42G3s4hX1XIhgJW/P7GVy+mKgErcjxNKm
         cXLGOg4lQHvsMRnnz+kSd63Etha09ExqFflKVL52C5XuN/ORKbm3nS4IoeO6Z7P56Q/b
         lyfUUOS6QZXL1/jVEtuTZ3ArIqkxPxGXWwhTmBtd558+4HWbWhMdsTsdgdOsmVt8MUkW
         42QW+w5LZTUoqD83mCEvojP3YOJhjkvjD2LlL8/K3KYCGa9NsKjxMF4cx83bTopHAuss
         BpEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Ahern <dsahern@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 32/36] net: mpls: Pull common label check into helper
Date: Fri,  9 Mar 2018 16:18:48 -0800
Message-Id: <20180310001809.138665604@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507920885870676?=
X-GMAIL-MSGID: =?utf-8?q?1594507920885870676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

commit b7b386f42f079b25b942c756820e36c6bd09b2ca upstream.

mpls_route_add and mpls_route_del have the same checks on the label.
Move to a helper. Avoid duplicate extack messages in the next patch.

Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mpls/af_mpls.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -714,6 +714,19 @@ errout:
 	return err;
 }
 
+static bool mpls_label_ok(struct net *net, unsigned int index)
+{
+	/* Reserved labels may not be set */
+	if (index < MPLS_LABEL_FIRST_UNRESERVED)
+		return false;
+
+	/* The full 20 bit range may not be supported. */
+	if (index >= net->mpls.platform_labels)
+		return false;
+
+	return true;
+}
+
 static int mpls_route_add(struct mpls_route_config *cfg)
 {
 	struct mpls_route __rcu **platform_label;
@@ -732,12 +745,7 @@ static int mpls_route_add(struct mpls_ro
 		index = find_free_label(net);
 	}
 
-	/* Reserved labels may not be set */
-	if (index < MPLS_LABEL_FIRST_UNRESERVED)
-		goto errout;
-
-	/* The full 20 bit range may not be supported. */
-	if (index >= net->mpls.platform_labels)
+	if (!mpls_label_ok(net, index))
 		goto errout;
 
 	/* Append makes no sense with mpls */
@@ -798,12 +806,7 @@ static int mpls_route_del(struct mpls_ro
 
 	index = cfg->rc_label;
 
-	/* Reserved labels may not be removed */
-	if (index < MPLS_LABEL_FIRST_UNRESERVED)
-		goto errout;
-
-	/* The full 20 bit range may not be supported */
-	if (index >= net->mpls.platform_labels)
+	if (!mpls_label_ok(net, index))
 		goto errout;
 
 	mpls_route_update(net, index, NULL, &cfg->rc_nlinfo);
@@ -1162,10 +1165,9 @@ static int rtm_to_route_config(struct sk
 					   &cfg->rc_label))
 				goto errout;
 
-			/* Reserved labels may not be set */
-			if (cfg->rc_label < MPLS_LABEL_FIRST_UNRESERVED)
+			if (!mpls_label_ok(cfg->rc_nlinfo.nl_net,
+					   cfg->rc_label))
 				goto errout;
-
 			break;
 		}
 		case RTA_VIA:
