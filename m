Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsGl66Xb7utJcpM2H6Orv+gFBauF/m+nvc6WDJN1AaF3zCYL78rmLVNbiv4KhYt9nruxzrZ
ARC-Seal: i=1; a=rsa-sha256; t=1521483810; cv=none;
        d=google.com; s=arc-20160816;
        b=EJJnhu7rbqx9+G/BpksuwMaaEYbrB6m1nq9g/CPXHdGB7oTJie7ycjLkfLWEJkVdEL
         82z6dl7aocwIVZc6blMqSqHTcbgZ0tq3SfROSIqipzJ0pJYFvtvzdx5Ph0E42kR8rftf
         xl6fG76gD/ute/JqaLmI5eI4Fpf4BXV5jsbc1HbMhjJ+2hfb4Cwi+N4kkWXk+n6CNSXr
         B0fqckO1KF+SGogfaSB/shKDldHKagyVBtXjdDmbTeSZZS1Ijs7v7n5ThtxAVqCqXTdh
         qOBK7lLb1jFdID3C6tVVe3mTFBipTk6djFiT5Mfx1OTaMhNW78Plqy254TBO4q2z34vX
         LYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dJN6T9PhY8rcXe1B5n++IE1ORxD4GiOKv2YxlVLo9aA=;
        b=yzksozvJE1/5jRg5V+xcixMQThgeXCsZjh5KmIxcbA2xcQW1rhDpEJsA01GFDpneCk
         pMzGWsutWh3ISOhX80c2D/Jer351vPLyIlFobmoCVktBz+z4ktNnPRpq3XNJLlgJLgTm
         rj2WN2efSJwM0/vyC6xNVtsLPc+SKYqQf85rC4UxvmqswaYcc1gpFoik703iCQKb86c6
         bk0lR/QfRhyi1G0iAdXYNw6jOpg507glp7Uvb5KEWKe1AcZZtd1y2hIBFJwhU2z+OM5L
         ueqsR/yWgshwz8skWqrfsPSoJvOlOtw+Yjx6cfsnksVWi3OiCN6U3QpVg2ePhc3RlztZ
         tD4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Leach <mike.leach@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 125/241] coresight: Fixes coresight DT parse to get correct output port ID.
Date: Mon, 19 Mar 2018 19:06:30 +0100
Message-Id: <20180319180756.380379105@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390840577337928?=
X-GMAIL-MSGID: =?utf-8?q?1595391408409058910?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Leach <mike.leach@linaro.org>


[ Upstream commit eeedc5421dd3b51de73e6106405c5c77f920f281 ]

Corrected to get the port numbering to allow programmable replicator driver
to operate correctly.

By convention, CoreSight devices number ports, not endpoints in
the .dts files:-

port {
     reg<N>
     endpoint {
     }
}

Existing code read endpoint number - always 0x0, rather than the correct
port number.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/coresight/of_coresight.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -149,7 +149,7 @@ struct coresight_platform_data *of_get_c
 				continue;
 
 			/* The local out port number */
-			pdata->outports[i] = endpoint.id;
+			pdata->outports[i] = endpoint.port;
 
 			/*
 			 * Get a handle on the remote port and parent
