Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49i1MnVoqvnzppppF6yqJsNAAvY+Dc4zVyMsI1CFWNgsbLJLfIjJxgog+LHiFidt8XqOcAK
ARC-Seal: i=1; a=rsa-sha256; t=1523399668; cv=none;
        d=google.com; s=arc-20160816;
        b=ARmBqos9+J2CCwch7THSLnKxgsFVFwzIghDd+bSld8zEf+bvpsMY3wZiJmERHpIq8b
         GDuvAQDJgkUW0CyR8jRjc3/5QTGIfw623MMrr75aQUHmAR0+GOt9gmCBEym9nQrtiqPy
         3GWshYfn2OmsGCctwjTgnhofcH2FH+x/gSULHJJDBoxvpxJn7IppaEs4xUVTfE8X3Ybk
         PO0zrAekS2do70S36bloR9wLpt50QPu1QEo7gDjdbRFG52AHKKHfkPPJHyrInZPIL0GL
         20z/yhe+tCm2go/k1GwJDc4lHX0KewL5YooKzIXrjYdOPY4F6QpRM3Ojs/MlDJTTEoVx
         87JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=d1GrlSHUdv8Nr7LDVeFjHbGcOotW+2/EPPARcTqywV4=;
        b=rHKYPQ/DkaNo/wOpcgtjOTYDisBXOEYX/uO23Ymjc7vjz0CemOKxU3qHK3t6x+M5Tm
         zZHYNZCznxEeQ1UjuRgFB0mt7/Cl5aVpVS/F4HzJYKj9V4LTOz/anbBOgR1JuJTjOM/3
         sfBt3nr37A5S4NHctbyLjp7SstV2GEt+eo4z5u+7KgOYYPaP5gHQErDgyXceU4vr6FS5
         mzYnWsWm6cHLCQdjoDmo0u9Tb0EtXMMly2ijCWmSGtiFP8S8kYQKMqpOw+F03YJA7lDu
         hDiH+2mMd0SgyAzAQfK8xMih4UFPSNPTdQmYXzJ7Sy6hktJjwME0gD88BuRUKrcR+Xz/
         Yuyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 021/138] PM / devfreq: Fix potential NULL pointer dereference in governor_store
Date: Wed, 11 Apr 2018 00:23:31 +0200
Message-Id: <20180410212904.578049322@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399843849765042?=
X-GMAIL-MSGID: =?utf-8?q?1597400330669848368?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>


[ Upstream commit 63f1e05f7fe9ca509c60154d6a833abf96eecdc9 ]

df->governor is being dereferenced before it is null checked,
hence there is a potential null pointer dereference.

Notice that df->governor is being null checked at line 1004:
if (df->governor) {, which implies it might be null.

Fix this by null checking df->governor before dereferencing it.

Addresses-Coverity-ID: 1401988 ("Dereference before null check")
Fixes: bcf23c79c4e4 ("PM / devfreq: Fix available_governor sysfs")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/devfreq/devfreq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -935,7 +935,8 @@ static ssize_t governor_store(struct dev
 	if (df->governor == governor) {
 		ret = 0;
 		goto out;
-	} else if (df->governor->immutable || governor->immutable) {
+	} else if ((df->governor && df->governor->immutable) ||
+					governor->immutable) {
 		ret = -EINVAL;
 		goto out;
 	}
