Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsJjh+G/jAJHBw56nsrJ1kJ/YaymgY9Nu2zNqAO6pvaGLzuslaEMvrPf+PvsciRt+qG81cz
ARC-Seal: i=1; a=rsa-sha256; t=1520451749; cv=none;
        d=google.com; s=arc-20160816;
        b=ct/UbiGAOtqTBKXVX6JNSXWgtXWKTIcdu8l4zt4/e4zDhWZUGywrwX8ayWgQwhWU1e
         3yBFEkFnRyHRIpoe9ee5gxxq3CZm4SnvAJDaZJFB4yAr+2I0PUZTlp+m1vEmDUt2sG34
         kAVqT4acwM+mWBImAcFHaqvpVlRWV6j6dUmjPcJg7SGVwcJV2Cu521vd+Y7ezywHB5Lb
         Eb4BqHHoXazs5tiN6qkP4jSmwltLHw2ZQANAXZN4ccPvjf4NMhIC1406TA4lZRYFK5fF
         iRuX6PARItnEWvdPYvWrJhwJz60sWIDA5L1mhVkV1UC4+kmFqNndrQUkfABkiz1m97/w
         5ULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZlhBeRPP2mqVnzEys3ckyXhwjhYBjM+FNra0ecO3JPw=;
        b=dCdBIBG/DL0kk7pzmNx0WKRInYT1HMABscpvkItgvkMDU1abR1x1qQy0ZPSgMkQmhP
         /UMffC5Any6iBiHFGU1Wf0menGGROYn1uf9gUu5ctWCNKcynATCX9451InnBD4No3k6F
         0pXn90A4D4yPynLdYyD7icuwbECyj6laxdbXudXuUmB8ocgHiXePrZRkyjd15gQBvADe
         GOPNnss3UWFj5LvPXy5Fb5AV9DVISw02q726+SKspc4gtcvbLlDCcPqYlgdVijWWWu8Q
         lZT4/Mw3PGbdK816ktT3zU94cOdruoPs84VA3HzQOMGcsmK1+EaZfTdMeH7y4hyJLuD0
         ffwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vlad Buslov <vladbu@mellanox.com>,
	Maor Gottlieb <maorg@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.15 080/122] net/mlx5: Fix error handling when adding flow rules
Date: Wed,  7 Mar 2018 11:38:12 -0800
Message-Id: <20180307191740.821519832@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309213337133574?=
X-GMAIL-MSGID: =?utf-8?q?1594309213337133574?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlad Buslov <vladbu@mellanox.com>


[ Upstream commit 9238e380e823a39983ee8d6b6ee8d1a9c4ba8a65 ]

If building match list or adding existing fg fails when
node is locked, function returned without unlocking it.
This happened if node version changed or adding existing fg
returned with EAGAIN after jumping to search_again_locked label.

Fixes: bd71b08ec2ee ("net/mlx5: Support multiple updates of steering rules in parallel")
Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1755,8 +1755,11 @@ search_again_locked:
 
 	/* Collect all fgs which has a matching match_criteria */
 	err = build_match_list(&match_head, ft, spec);
-	if (err)
+	if (err) {
+		if (take_write)
+			up_write_ref_node(&ft->node);
 		return ERR_PTR(err);
+	}
 
 	if (!take_write)
 		up_read_ref_node(&ft->node);
@@ -1765,8 +1768,11 @@ search_again_locked:
 				      dest_num, version);
 	free_match_list(&match_head);
 	if (!IS_ERR(rule) ||
-	    (PTR_ERR(rule) != -ENOENT && PTR_ERR(rule) != -EAGAIN))
+	    (PTR_ERR(rule) != -ENOENT && PTR_ERR(rule) != -EAGAIN)) {
+		if (take_write)
+			up_write_ref_node(&ft->node);
 		return rule;
+	}
 
 	if (!take_write) {
 		nested_down_write_ref_node(&ft->node, FS_LOCK_GRANDPARENT);
