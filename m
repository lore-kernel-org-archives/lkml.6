Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtdhdwgv9U6WxAI3p2QvbOz/X6b4IsxnLdOhvNIeom064v/lBWElmPlVlU1Pf+EUjjlbig6
ARC-Seal: i=1; a=rsa-sha256; t=1520955336; cv=none;
        d=google.com; s=arc-20160816;
        b=S3Ln9HckDUQTNXyruv/8W4mVsfxAZ2DGacnsT8UnvVgOZ5NFTPNMPi0dD+y4Dv0FG3
         c6mB4Eaw4Ya6y+3l9Ha3MfzVGInacUbHikT2+X+riXPRjQe4eFu93ey1IiQHcKQbpbkI
         AuPqHYyElJEyNpywEFJuAZpkNi+rXXydbPLHlcwQRLot2lxWIjQ0Wsw+wlmv7/9Oayjw
         XDxNuNmz+gIrSLVUZFAoG2zwmGVSRN7Qu2CweLdygVgh6snXilW5p13x3dLxoFnIMSxm
         teyQr//vnCU//N9VGdDCeUaK0vf2g07Gw8AOjzVALeavR752yGJhqzD2a6rvT8ziB+4b
         CqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=b//iNS/R6SvqNr+VAquxk/3U5YoqUMyMFTkB5Nl6sSo=;
        b=1GP4iK3/wjhuzINNUaavK2eyU/E2qENsa/8ja5mQrhEIAZpepPHS5EdKWxhkkC8MZs
         WnZ839lSp6cMn52OJWmABFCzwGvhGKXNdJEdBBUDlt2zC5rUWyKL3HStg/vPgUWPMSDw
         hK9KqDHv4AV2eLN/K6ZpU4h1Ibi3Zd0gKT5mGdtuLoZa30I6e9/cSTJZxVvqmhWlupNz
         QKwDk0cH5ug8rGk0XteKYLgF7xGExeneAbYEY4qvBP4NQJFkpVeiOhbSvtO3ML1//g/V
         K5EdvpsYW/BXBXXdMvNZTv6/TgMlM8ldOOBXr1PvAsojEmr658HX0GnBycGjBFMJakmd
         U0Yw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+845a53d13171abf8bf29@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 015/140] netfilter: ebtables: CONFIG_COMPAT: dont trust userland offsets
Date: Tue, 13 Mar 2018 16:23:38 +0100
Message-Id: <20180313152459.139448737@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837091715728508?=
X-GMAIL-MSGID: =?utf-8?q?1594837262769098018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit b71812168571fa55e44cdd0254471331b9c4c4c6 upstream.

We need to make sure the offsets are not out of range of the
total size.
Also check that they are in ascending order.

The WARN_ON triggered by syzkaller (it sets panic_on_warn) is
changed to also bail out, no point in continuing parsing.

Briefly tested with simple ruleset of
-A INPUT --limit 1/s' --log
plus jump to custom chains using 32bit ebtables binary.

Reported-by: <syzbot+845a53d13171abf8bf29@syzkaller.appspotmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/ebtables.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2053,7 +2053,9 @@ static int ebt_size_mwt(struct compat_eb
 		if (match_kern)
 			match_kern->match_size = ret;
 
-		WARN_ON(type == EBT_COMPAT_TARGET && size_left);
+		if (WARN_ON(type == EBT_COMPAT_TARGET && size_left))
+			return -EINVAL;
+
 		match32 = (struct compat_ebt_entry_mwt *) buf;
 	}
 
@@ -2109,6 +2111,15 @@ static int size_entry_mwt(struct ebt_ent
 	 *
 	 * offsets are relative to beginning of struct ebt_entry (i.e., 0).
 	 */
+	for (i = 0; i < 4 ; ++i) {
+		if (offsets[i] >= *total)
+			return -EINVAL;
+		if (i == 0)
+			continue;
+		if (offsets[i-1] > offsets[i])
+			return -EINVAL;
+	}
+
 	for (i = 0, j = 1 ; j < 4 ; j++, i++) {
 		struct compat_ebt_entry_mwt *match32;
 		unsigned int size;
