Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226PYcqtOEs8aqkrDwOltwG/PmPeP9uMEvzNUT39SWgo5zqFhe3gWNh5dCCVG2JRkaTlh87m
ARC-Seal: i=1; a=rsa-sha256; t=1519217750; cv=none;
        d=google.com; s=arc-20160816;
        b=0cOXZjnnGLG0vaQHisJDV2ZmNALjePVZry78nx4a5JkCDbDqzwX9Br2hv4N5SieAIj
         u6bwuObhkdhMwjQGmyfMnZp80Ijo239qcQbfZxkL2Xdcuf+4VV0HNoZ2XpNizGkCR7Co
         pOU/paQNIFfcBOf2XYuy4MHtsmTsu2ckg/c6JPcV5nuTjJyIRZ1yV3dpoakFHJaMkRr9
         9/myqDdZX5teUrs3jUijyghYcLble3Q+wiJCq7zPV/Y711Df6thLU7OeSbDAfSUvp2FB
         7IfRJ+ovh1fUElaR3ovmxl01w+4gf+YR8PPAhDotc5AP6j2BDkAtJxXMb0+nbKBPFiol
         14wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZT946jLa3GMtj7GFed0+V5Z6mUnaWD4zieRIC6Nf7Uw=;
        b=RvXMlLCXYC1zUKhzBHoP7Pj+qZKQ1did0dF5ET1ksC/JSupOwSd9pCFSBatlKqypuq
         8/bvZUHBX2hhq4+7gVW8pUHvWJXDIQoxNkZum0Ka2UFZWEHZJWXckJonxWdT1nqVIhYQ
         A+/NAdKQAb7G1rmzg1FkdTCsG4J/hatQ70Yy+XTGcFYppetzmYC3E2nOL+WDcSnmJER0
         efJaxVUtDbLz+jMWBFflu5w+Pk06xiRhTMdq6T7ZIbGYJjFLAwlL3f/qWeeNm2KvByIR
         aB2GvN3QAa0QV9/Ge3gIVWYIYeEbqRqX+H1Dh2QPzbzyBpEqzJ3UrNmkuaRGJfYBrKI5
         j8sg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 4.9 40/77] PM / devfreq: Propagate error from devfreq_add_device()
Date: Wed, 21 Feb 2018 13:48:49 +0100
Message-Id: <20180221124433.865789803@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014614609921492?=
X-GMAIL-MSGID: =?utf-8?q?1593015271755425745?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit d1bf2d30728f310f72296b54f0651ecdb09cbb12 upstream.

Propagate the error of devfreq_add_device() in devm_devfreq_add_device()
rather than statically returning ENOMEM. This makes it slightly faster
to pinpoint the cause of a returned error.

Fixes: 8cd84092d35e ("PM / devfreq: Add resource-managed function for devfreq device")
Cc: stable@vger.kernel.org
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/devfreq/devfreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -684,7 +684,7 @@ struct devfreq *devm_devfreq_add_device(
 	devfreq = devfreq_add_device(dev, profile, governor_name, data);
 	if (IS_ERR(devfreq)) {
 		devres_free(ptr);
-		return ERR_PTR(-ENOMEM);
+		return devfreq;
 	}
 
 	*ptr = devfreq;
