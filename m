Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsPrIXceX+ckniph4Fz1HS0lMayf/xzg8AKp+mQhHsLQXBEktkRWTW+AKaMmMf1TflLkxiD
ARC-Seal: i=1; a=rsa-sha256; t=1521800141; cv=none;
        d=google.com; s=arc-20160816;
        b=rEU06tPh3sBiqSSsXDXniWrNvRxl8/OwM6qCz5VJPg5FMGRpt0LoSIWMm9NCWFnFN5
         HfixIeM0jxldcjrqKL8LMHRjEKmsT+ogq/2QXtLkmL+LzW+fa0KVGYN3ZkSd/3Krn9KS
         jm73hsywlbwo/gu95KXISM9a9wBfdRUhszDe1vWoXU+m8FGPVsQOrXW3uavRTKjwK5Nj
         iwv2DdaXqJJcRYEw5RIdI3afxFyz6fp7ZHKdefwbDyEuGZtWB6g/VAtP9fvCWxUPLoU2
         d9NgRSHadzED4+fhxRWjozkaRCS8sHskRD6QYLIyZEFYTtvkbu3Qt94orKb9EwmmLzvK
         9DCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/EycqQeDX2166NwEkdUusuaA62q+exWWi02oc5Yyyr8=;
        b=GVFM5ylvgWvmhj1cgp3g/82tP032IEJnfAr+3HbpVG1Df9dRIFepmMDe0CX+pAuXru
         7B00ulrravuix5k1cF8IGqUzenUhhFhImgpA56AsbpnmOYVgzKqLrIslF6o2LXAuu8IA
         swEdi8TCBTM3nCBw1GwjwZLc/LYDg6qxlcwpJYrqca1VRrBiKuvXn7ULrA4opE8cRevC
         iqoWCXFoBRQ2Uww8Hi2qlx4uz85QdD6pN6Oi4HdFF6onVMUIzLy1BpiqcNjI9LdkXw66
         KlTRET7mMP9pECYlXVnFqovA7n0fk0z7plQKO7goovd7tcSuXzW/Lxz8U/QtvT1qE5kp
         B0mw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guoqing Jiang <gqjiang@suse.com>,
	NeilBrown <neilb@suse.com>,
	Shaohua Li <shli@fb.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 63/97] md/raid10: skip spare disk as first disk
Date: Fri, 23 Mar 2018 10:54:50 +0100
Message-Id: <20180323094201.150412201@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722709083060943?=
X-GMAIL-MSGID: =?utf-8?q?1595723104474111325?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shaohua Li <shli@fb.com>


[ Upstream commit b506335e5d2b4ec687dde392a3bdbf7601778f1d ]

Commit 6f287ca(md/raid10: reset the 'first' at the end of loop) ignores
a case in reshape, the first rdev could be a spare disk, which shouldn't
be accounted as the first disk since it doesn't include the offset info.

Fix: 6f287ca(md/raid10: reset the 'first' at the end of loop)
Cc: Guoqing Jiang <gqjiang@suse.com>
Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid10.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4044,6 +4044,7 @@ static int raid10_start_reshape(struct m
 				diff = 0;
 			if (first || diff < min_offset_diff)
 				min_offset_diff = diff;
+			first = 0;
 		}
 	}
 
