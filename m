Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227HTAeChH+rUG+oaxVbEf+ESBxG0JHT3jlxOH+8XvQTNt75WxSuX3C3mg5mP7xPxl6OwloI
ARC-Seal: i=1; a=rsa-sha256; t=1519218659; cv=none;
        d=google.com; s=arc-20160816;
        b=mjih5ciuOghxzB4JgL3asFDTgMheIAIJwuweQXv3BjOWvQw/QdWDisqB2qlJdq/yd/
         48hwMaRvfsVZE8xdgnB+nqPT0O9NRDriu4BX4mGi5bafRUBdyDxzIxsQhIkYPGGhoIj/
         0MZHS61xdmnBNRYCiOzra+RArcPBmSkX9ab/iWGeZfLcwABvUilBYqn56w0Ern+FSw2o
         DcB6ZjcO7w8Dpm8UwuepeWQ69YFwEDgE/LVGNuyKgmteDFmntwedTRGoQ1XqSsrUFrrF
         m9Xozmi2ruYmlJkI1LTZF4PRFpqEC7B7a9t0QXEkif/lMBhdKPTmV5BMZiEodbw8fq1f
         LUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6b1yBe1TzyaBojziohlHxfHf4w6L1r9JX3Dpdpa3jrA=;
        b=CLRghkMcVjVruvBisiTEgTTI53H4hX7HaSqJWOH5dzkPGQ2RNUlgcMuYi5/insEUGO
         TY1TS6Db7O+d6U4kdD7tcB0ukS195hTfU2Yox2rAlyGdxhoN69/RoxeolYlME5cDUkBe
         zdTdL3IWmp/0yla7TFL1oQRPepfD5Ooco1tw3/uyNR7+Dqt3nCpEG6rlfBv/Vx2C6oF0
         V71UuBG0XBrxHLVL4mkONoTkZSGz7N3heROP3Aecziou3anuwUzL3KiExAoCK1uG/scc
         x+mSmqLlqiYek7EPMk4pPZYAmWhtWpOCZB5MXsNvZiVx4PuqfNZ3jgJakNrhJNu0b3uZ
         3WsA==
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
Subject: [PATCH 4.15 104/163] mlx5: fix mlx5_get_vector_affinity to start from completion vector 0
Date: Wed, 21 Feb 2018 13:48:53 +0100
Message-Id: <20180221124536.020253137@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015689231116812?=
X-GMAIL-MSGID: =?utf-8?q?1593016225175166369?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1238,7 +1238,7 @@ mlx5_get_vector_affinity(struct mlx5_cor
 	int eqn;
 	int err;
 
-	err = mlx5_vector2eqn(dev, vector, &eqn, &irq);
+	err = mlx5_vector2eqn(dev, MLX5_EQ_VEC_COMP_BASE + vector, &eqn, &irq);
 	if (err)
 		return NULL;
 
