Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225JvsrdWTIYxlDkk6PQGGnD4kNGVJHyT4spB3Vml2GgHndolMgzFGmHei99+mR6VD8gO0X7
ARC-Seal: i=1; a=rsa-sha256; t=1518709500; cv=none;
        d=google.com; s=arc-20160816;
        b=vhDHmoIzGFz2v7d3SSA7DZi8YNw+p04pusa/tkspf+KNj4gH+DGsXL5qMoZhnLpG6t
         Kz+MPd4l+P6QR1zTZj1GEahMQBCSNYAOCU+H7E0aEFkKcb5H4T7AKz4hdbJcMER+HZkE
         Iq1nQizGNnVYLimosrP5KNbjlbtxqGpPFiHCikBAxslhGV5R3XbcBmMrZF7Z7lyALz5J
         lm4wFWxQVUa3df8c+Px4/LmqrRoeuuLHi+OsyerNk+ed/ZLDSVTeImnrjUGOiDfqHhOj
         MDpnS9I0709XnFjv+nFrDCA0i+ektbDVBBFMO0NglDTN42ayyXr0fGmBtc9j7TkuiVWN
         2G6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/rHwnfegQDxwooiDjPkL3L3NpQqet5xELdzfPGOVQFk=;
        b=BXQzo1Ovzip7a2qAF0xIhiacrDCaPM/H3WUE7VIwDT2QA9XaMvHd3h+1XX8OUMdR5j
         ScS2X02fwFRoNFaabdvk4mHvPDLldB7RDkbI+1hhjMACr4bJsNC7EH9N7sza3tK/imRR
         LEY6VZnOC7C33rdwkr9VekCjxRD+IDH66Wr1xW05Ffp8rdunik7j8PNQ9rgDkoz4Ows9
         m7ZmRXeH1cLh33xOhiu0hWV+ps37IP6LU3ON0SuHIZJKoJeCrac+71knMuZzZkSRF7iT
         J1kXdfGUidA17Llin0JVlnb1Hm7JHIkNmnFsfhWKsBwhhFgC8Omahe85tJIHlNlTA3QP
         0ZhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.15 140/202] ASoC: compress: Correct handling of copy callback
Date: Thu, 15 Feb 2018 16:17:20 +0100
Message-Id: <20180215151720.407230886@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592482333159672349?=
X-GMAIL-MSGID: =?utf-8?q?1592482333159672349?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

commit 290df4d3ab192821b66857c05346b23056ee9545 upstream.

The soc_compr_copy callback is currently broken. Since the
changes to move the compr_ops over to the component the return
value is not correctly propagated, always returning zero on
success rather than the number of bytes copied. This causes
user-space to stall continuously reading as it does not believe
it has received any data.

Furthermore, the changes to move the compr_ops over to the
component iterate through the list of components and will call
the copy callback for any that have compressed ops. There isn't
currently any consensus on the mechanism to combine the results
of multiple copy callbacks.

To fix this issue for now halt searching the component list when
we locate a copy callback and return the result of that single
callback. Additional work should probably be done to look at the
other ops, tidy things up, and work out if we want to support
multiple components on a single compressed, but this is the only
fix required to get things working again.

Fixes: 9e7e3738ab0e ("ASoC: snd_soc_component_driver has snd_compr_ops")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-compress.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -944,7 +944,7 @@ static int soc_compr_copy(struct snd_com
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
-	int ret = 0, __ret;
+	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -965,10 +965,10 @@ static int soc_compr_copy(struct snd_com
 		    !component->driver->compr_ops->copy)
 			continue;
 
-		__ret = component->driver->compr_ops->copy(cstream, buf, count);
-		if (__ret < 0)
-			ret = __ret;
+		ret = component->driver->compr_ops->copy(cstream, buf, count);
+		break;
 	}
+
 err:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
