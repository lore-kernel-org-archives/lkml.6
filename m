Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvmuuwNNJgtEJSwP6TFynyq4An+fqj7p12HOBP8zMR1QqvVmtHKgoZtGqINp4Kr2eb1lpbu
ARC-Seal: i=1; a=rsa-sha256; t=1520641363; cv=none;
        d=google.com; s=arc-20160816;
        b=EjVqAXZl7uCC/Z/45zLMuJKyyw9uEnbnioIuiTh7vGOdHhMdGXF2lEOcg9FpKhdLdQ
         n5D/2JjFQXx7lQFdYhhqjrHX0dnd+X38ppT1So8VIWncFl+LB2TteQ6kODWbHSfvTtxp
         8epgU+mxddUw5lAEH3WVUyKHK58JhJCyhgw0+X1X7Ecx8fCoF7S4l94WX5rZTVbalTLF
         lfziXXvuyFLQjCo5ngy5D/jHWHq509wbuZFkbYSAMU8fxWwDQlJLnARwPmEnAcVX74Ea
         axhjLTMVNhmb4Qu9JIkRE1VK7XYg6Zy+BuU5u2Tbm8CTK+TYw0hcGP0aTF7j666RwN55
         aDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IWzHZGIKBE/IVVHaaU26iKWh687Lxs57SV4DsZdcp74=;
        b=TwQUK7KCSFWy6Zi70blDw7VKt1XAU2syX1hmpgdETs82xl4+7tmX+SpKTXYq/NDoYN
         ipUBcntTD0sZYT3tFTFbR9sGp/q9pD4i5tnC99YfKoFBDhba/TexH+QVVKOj2pRl2QzZ
         /NQE5jDgNudixOuLErydcAMbNUm9GCNNEJv7irQ3Xiq+jEbBkgm3fqDEdn38/JNY66Yg
         Pd5BkJLR+cembbtD4G6zL35Oqzx+wzlpHd0ZMNxYYNE+x136omfSBXl0oYsVtVAPJh2+
         /SkAPCFfcGUYiX286n1LiPv0WAc7sx3nI9r9jcKsTIiTsn45J0SMH5ELf1Rw06QdJjYl
         tYQA==
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
Subject: [PATCH 4.9 57/65] net: mpls: Pull common label check into helper
Date: Fri,  9 Mar 2018 16:18:57 -0800
Message-Id: <20180310001829.699068126@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507920885870676?=
X-GMAIL-MSGID: =?utf-8?q?1594508038518987673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -756,6 +756,19 @@ errout:
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
@@ -774,12 +787,7 @@ static int mpls_route_add(struct mpls_ro
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
@@ -840,12 +848,7 @@ static int mpls_route_del(struct mpls_ro
 
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
@@ -1279,10 +1282,9 @@ static int rtm_to_route_config(struct sk
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
