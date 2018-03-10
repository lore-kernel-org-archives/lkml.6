Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELul+etB6jeSq0XENrDm5VxU4rdjKJUhSE3Yj/nfDBiNbsJqXICfeL72mwZbZA+8avm0vJLy
ARC-Seal: i=1; a=rsa-sha256; t=1520641253; cv=none;
        d=google.com; s=arc-20160816;
        b=rTjMHp+zJL85Yml1reDDRPSB8LOWOq7JDXehzSRP5QDIOeBTOobQvCegZhw87T3NYJ
         KGKfyl/Roun85dkjB6RokR/qF95FlwtSbJ9BGKVMhjsoRY5x+gui345L7jX3aUvirir+
         GmnMr3n8wtKiNxGd5TtsOg/4WEKQKkUQhjR39P8gGOfCSSmmi4mdMR2glrsIaGe2OdAt
         BShWqOJzHuDUdMAJSlxLAbgT7w7+zBp8mYJ0dmfoK7YAXNvxeE3mGCFZsJ/MhHSA0ZZl
         wn7jFiglwGkOmpZIvCU1rkiUyMatwAl1k/OB1mx6tn2FCybCO8w8jCa57Nj0p/jUPZBJ
         /WYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eU2qyRh8JiLw+69zsQ2cnj1xB7kFXRXxfV2Kh8MJZug=;
        b=pJVa1GEbesLVbNYZFPxXM0lxBenxWKyGGJR6Nq815JCXhtR8NWHIB4Zv//DJKUj7Ls
         Z6XA+TvH2BpnjtpKynzWi6enHAknWxSArXbUBOBVnF9UpygxDVhKuGF0s0NcZvKfPMRp
         dwVHdgyReXndn8y4+AiWp+UH/PLWNBp7/Sjlt2y0icBCUA3nAyLGwsDDjfWDYE3dEEV4
         o9XCx4e7qhrMGQ1fGFgjFpG8ak6bm3TLikCLPOXAanMzqftsNLEWXFyNwCs5L9abURV4
         WdgCjV82Q+z+IAnfKJxWMowICZdyqpTaw5YHIA7VtmYmMi/UNydjjaPNJi2EjOl2iBjG
         GSnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 33/36] mpls, nospec: Sanitize array index in mpls_label_ok()
Date: Fri,  9 Mar 2018 16:18:49 -0800
Message-Id: <20180310001809.184616649@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507923154596222?=
X-GMAIL-MSGID: =?utf-8?q?1594507923154596222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 3968523f855050b8195134da951b87c20bd66130 upstream.

mpls_label_ok() validates that the 'platform_label' array index from a
userspace netlink message payload is valid. Under speculation the
mpls_label_ok() result may not resolve in the CPU pipeline until after
the index is used to access an array element. Sanitize the index to zero
to prevent userspace-controlled arbitrary out-of-bounds speculation, a
precursor for a speculative execution side channel vulnerability.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 4.4:
 - mpls_label_ok() doesn't take an extack parameter
 - Drop change in mpls_getroute()]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mpls/af_mpls.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -7,6 +7,7 @@
 #include <linux/if_arp.h>
 #include <linux/ipv6.h>
 #include <linux/mpls.h>
+#include <linux/nospec.h>
 #include <linux/vmalloc.h>
 #include <net/ip.h>
 #include <net/dst.h>
@@ -714,17 +715,20 @@ errout:
 	return err;
 }
 
-static bool mpls_label_ok(struct net *net, unsigned int index)
+static bool mpls_label_ok(struct net *net, unsigned int *index)
 {
+	bool is_ok = true;
+
 	/* Reserved labels may not be set */
-	if (index < MPLS_LABEL_FIRST_UNRESERVED)
-		return false;
+	if (*index < MPLS_LABEL_FIRST_UNRESERVED)
+		is_ok = false;
 
 	/* The full 20 bit range may not be supported. */
-	if (index >= net->mpls.platform_labels)
-		return false;
+	if (is_ok && *index >= net->mpls.platform_labels)
+		is_ok = false;
 
-	return true;
+	*index = array_index_nospec(*index, net->mpls.platform_labels);
+	return is_ok;
 }
 
 static int mpls_route_add(struct mpls_route_config *cfg)
@@ -745,7 +749,7 @@ static int mpls_route_add(struct mpls_ro
 		index = find_free_label(net);
 	}
 
-	if (!mpls_label_ok(net, index))
+	if (!mpls_label_ok(net, &index))
 		goto errout;
 
 	/* Append makes no sense with mpls */
@@ -806,7 +810,7 @@ static int mpls_route_del(struct mpls_ro
 
 	index = cfg->rc_label;
 
-	if (!mpls_label_ok(net, index))
+	if (!mpls_label_ok(net, &index))
 		goto errout;
 
 	mpls_route_update(net, index, NULL, &cfg->rc_nlinfo);
@@ -1166,7 +1170,7 @@ static int rtm_to_route_config(struct sk
 				goto errout;
 
 			if (!mpls_label_ok(cfg->rc_nlinfo.nl_net,
-					   cfg->rc_label))
+					   &cfg->rc_label))
 				goto errout;
 			break;
 		}
