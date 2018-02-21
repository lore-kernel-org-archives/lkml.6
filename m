Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225tlkI8ZjksrvyzO33+GlsRHG+Pf2NHdaW4/K57tWpRqf0I3OToUrXO/RbqNBDqBm99DuIv
ARC-Seal: i=1; a=rsa-sha256; t=1519218148; cv=none;
        d=google.com; s=arc-20160816;
        b=L9NyqjKvlSDDvVVcBgov5I84pppi+ckByiRFMB5pKr76Wf/p4WeMjxsRTzUnIHS/ev
         1spafbwIRYS5lcf/24co5czsOHtJH3qyfaRnVQovHxliIsz20lc47nZLY47eKew/eDID
         3w14vopKGVNb+cFgvkrD2XCBclTuQZieopmQeBUlFySpZOFeudwfxQpmbeUng4hPzFle
         bmsqNDplIgCwnG9jlOmeXjx8NNInUOf2GO42n2hTkzcrb/GAQv2csSAetPjOiuT/euPy
         YlmNyTtDV0gRNihzcj49dNNlh4KbrQd1SPiTFBTJ/MqO6edK/PPOxV/WJjXPF2o210wj
         Arrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P/iIGKHFhL3Uz5Qr4vowLEqg8gzF/Mk58IpLM+qaJv4=;
        b=FGqBMYkc3QhK3UPXUc1/ZGvvJxLOzox5DNNfPR8xsTD7FL974Oe1b0wu104sii3zjY
         cEEFncZ4QOc8KuWtjeAd8+KFDpDlnxim7Cj7MNr49Oj+nRf0jnnzIkjepwkpH5gOA8vP
         sA35kfsszPjQcb9QkHtQkTQNpM4NuoOX5piC9JlTn3X6VoBLydp919TFM5iQHEORSyDv
         Iq7ZKkaRAdY86rG5QmP8Gh8EcwJrfnKbfBYY1zNW+8F6vtZjXHi1LOqYMtiy58ffedQd
         rqMa35X2qaxBqL0na9+5e8C44BcNXrtSOqWYxm9WcRF3cjdGeRTmEzQYqoC5MBimZM+B
         1cNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Logan Gunthorpe <logang@deltatee.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 103/167] mlx5: fix mlx5_get_vector_affinity to start from completion vector 0
Date: Wed, 21 Feb 2018 13:48:34 +0100
Message-Id: <20180221124529.994563545@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015689231116812?=
X-GMAIL-MSGID: =?utf-8?q?1593015689231116812?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>

commit 2572cf57d75a7f91835d9a38771e9e76d575d122 upstream.

The consumers of this routine expects the affinity map of of vector
index relative to the first completion vector. The upper layers are
not aware of internal/private completion vectors that mlx5 allocates
for its own usage.

Hence, return the affinity map of vector index relative to the first
completion vector.

Fixes: 05e0cc84e00c ("net/mlx5: Fix get vector affinity helper function")
Reported-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Cc: <stable@vger.kernel.org> # v4.15
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/mlx5/driver.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1201,7 +1201,7 @@ mlx5_get_vector_affinity(struct mlx5_cor
 	int eqn;
 	int err;
 
-	err = mlx5_vector2eqn(dev, vector, &eqn, &irq);
+	err = mlx5_vector2eqn(dev, MLX5_EQ_VEC_COMP_BASE + vector, &eqn, &irq);
 	if (err)
 		return NULL;
 
