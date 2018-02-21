Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2246BXlV0Ysevy2e/s/DfzV9aoa11AICU5CK6uFPDDcpSl2jBrBJLyR7EfRZnNTx7E+K+Sfy
ARC-Seal: i=1; a=rsa-sha256; t=1519218200; cv=none;
        d=google.com; s=arc-20160816;
        b=I8cTku+w80DVUphgMe7/MK3HegGbi6/m8hf+SAjFnXUuhk7DoUoB3mteQDxAtbru3n
         6lmnI01+RYmkSqgsC7Yu7jOrI/5GW0w1MHEDj0F+2PsAchLDTUT+Fj2swkDNY8bE4U7s
         95ZO9sE9FAJDaoz8ABmpQ/1L2e1q+1RG/XMfvQH90zR2043f1YCfONC5eDipOFPMWOoo
         OQYW4Sx6feAjNB7td9UTf0bHgUQ8oAaDDKi1SkgY+oGEO5Zr+Px/evLKF4TikmAc8nHL
         Yovc7CpnafUMXdx5xyhQZiQpCmwcryk/UXfwH1LZ/23zuqMX5ODTKND8SrlJXPrx1dbe
         /MhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=++53kGK3rxUXgE6KAZtguoi0RVLPlZW9pxThL8AFoog=;
        b=DLtHuEfZRwvLaD8kQcGY3PMemsNn2Vud+r4qnVltWyaJsfMLerdZhK3BCd6pBNLUbn
         c1HWe3/VHi4RzvQIZR/jareS1stCEK/42UTSyt9Pj9T3ZkHm15cFbmua8mnKaQZIpaeV
         jNqFmrhkeALLxiKJFSRhvBMz+WOBgbVMqQG2YKmiLZhYMWgiWOK/JDxE4HISBVPnL3I0
         csWBnCXbHjk3BNPgLHiqFfQGOW1DCg2umGd7PrkQCbDx/P+puRuE6SqHU0VeQs6dQdce
         HzirwS2wtptzZ9f317/1WKe1TKGFIwqmyhBlbP2FacPgkU+E5TelZkKrZtNpCJikJ6ME
         Rmmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 123/167] mpls, nospec: Sanitize array index in mpls_label_ok()
Date: Wed, 21 Feb 2018 13:48:54 +0100
Message-Id: <20180221124531.269341715@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015743562020219?=
X-GMAIL-MSGID: =?utf-8?q?1593015743562020219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 3968523f855050b8195134da951b87c20bd66130 upstream.

mpls_label_ok() validates that the 'platform_label' array index from a
userspace netlink message payload is valid. Under speculation the
mpls_label_ok() result may not resolve in the CPU pipeline until after
the index is used to access an array element. Sanitize the index to zero
to prevent userspace-controlled arbitrary out-of-bounds speculation, a
precursor for a speculative execution side channel vulnerability.

Cc: <stable@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mpls/af_mpls.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -8,6 +8,7 @@
 #include <linux/ipv6.h>
 #include <linux/mpls.h>
 #include <linux/netconf.h>
+#include <linux/nospec.h>
 #include <linux/vmalloc.h>
 #include <linux/percpu.h>
 #include <net/ip.h>
@@ -904,24 +905,27 @@ errout:
 	return err;
 }
 
-static bool mpls_label_ok(struct net *net, unsigned int index,
+static bool mpls_label_ok(struct net *net, unsigned int *index,
 			  struct netlink_ext_ack *extack)
 {
+	bool is_ok = true;
+
 	/* Reserved labels may not be set */
-	if (index < MPLS_LABEL_FIRST_UNRESERVED) {
+	if (*index < MPLS_LABEL_FIRST_UNRESERVED) {
 		NL_SET_ERR_MSG(extack,
 			       "Invalid label - must be MPLS_LABEL_FIRST_UNRESERVED or higher");
-		return false;
+		is_ok = false;
 	}
 
 	/* The full 20 bit range may not be supported. */
-	if (index >= net->mpls.platform_labels) {
+	if (is_ok && *index >= net->mpls.platform_labels) {
 		NL_SET_ERR_MSG(extack,
 			       "Label >= configured maximum in platform_labels");
-		return false;
+		is_ok = false;
 	}
 
-	return true;
+	*index = array_index_nospec(*index, net->mpls.platform_labels);
+	return is_ok;
 }
 
 static int mpls_route_add(struct mpls_route_config *cfg,
@@ -944,7 +948,7 @@ static int mpls_route_add(struct mpls_ro
 		index = find_free_label(net);
 	}
 
-	if (!mpls_label_ok(net, index, extack))
+	if (!mpls_label_ok(net, &index, extack))
 		goto errout;
 
 	/* Append makes no sense with mpls */
@@ -1021,7 +1025,7 @@ static int mpls_route_del(struct mpls_ro
 
 	index = cfg->rc_label;
 
-	if (!mpls_label_ok(net, index, extack))
+	if (!mpls_label_ok(net, &index, extack))
 		goto errout;
 
 	mpls_route_update(net, index, NULL, &cfg->rc_nlinfo);
@@ -1779,7 +1783,7 @@ static int rtm_to_route_config(struct sk
 				goto errout;
 
 			if (!mpls_label_ok(cfg->rc_nlinfo.nl_net,
-					   cfg->rc_label, extack))
+					   &cfg->rc_label, extack))
 				goto errout;
 			break;
 		}
@@ -2106,7 +2110,7 @@ static int mpls_getroute(struct sk_buff
 			goto errout;
 		}
 
-		if (!mpls_label_ok(net, in_label, extack)) {
+		if (!mpls_label_ok(net, &in_label, extack)) {
 			err = -EINVAL;
 			goto errout;
 		}
