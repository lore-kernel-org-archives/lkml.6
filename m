Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuyjwDByWp4cbDe53eUOWlH8tu8jTT+w+NdZKXBtY08lrJoenHIgkhpi1w7bw+b2ZKwRZGp
ARC-Seal: i=1; a=rsa-sha256; t=1521214165; cv=none;
        d=google.com; s=arc-20160816;
        b=h/LT46Ud89L7p4a1yvrL1vNJgc6ilhY1YV4iish/xtzSc+aqxOffcJASbJRrGb+Ppz
         igEGIja82Y/k8v9TKPivqYwlbaRfteOTGZBSDggoJ9Oha9IKR07/PuDsF8ck363d2Cec
         eUqfSKbBAx14VJGw1eGDiZfRrzDrODp6EV/p1erCT+HHiRqTO4MT8Rs+vpt0u0m2jeOf
         smzVbr0jhzCBc5LiYBl2X/YIdyxT/iyCRFExH74CWMKDWQnBYnFzQXHa3yjxxqtHPdMV
         GVwMimUvK6swhVMCjY2mEp1MLNN52499rTdl6HXWZJKkl+YBXyKfUIjkAh3vxrqOfx9O
         KWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o8PAQlZNIUNN1BpsGNMOxGdU+/TRSgHc6T91JVXS3JM=;
        b=fkxbNIG4GJaaD0nhT048cKydiyQI/tIjf6aRMeVTHjuM1vT+QPDPrOJXitipf9cy1o
         UlX2wtquHEoA/R2qqfPhKlG8bSH/VV1vkid7Jnn0435tCndKIYB62JvY2t6BCsn/ExlD
         LvTh5eIgWBLY9eKUCZVCGpovL6ZBdOtOVRobjrK9XnrkNDWYiXDTF3wHlsUBQrtrw9R0
         VrkSMT5vaG+ZqO/UNyBVbtTFy7e+EECgvCsKlFSeuLK/GdGbqwS9O8/AbSvJydoVvg+e
         yzPSJyBB5ccvhZt3RClhlLTgHbtn4jTTssIMcPVe0kx3FZ1j6iH0HIWsVcaRZjcImlZk
         VAWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH 4.4 63/63] fixup: sctp: verify size of a new chunk in _sctp_make_chunk()
Date: Fri, 16 Mar 2018 16:23:35 +0100
Message-Id: <20180316152306.841971676@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108469216565155?=
X-GMAIL-MSGID: =?utf-8?q?1595108665158711784?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Ben writes:
> > +	int chunklen;
> > +
> > +	chunklen = sizeof(*chunk_hdr) + paylen;
> 
> I think this length still needs to be rounded up (with WORD_ROUND here,
> instead of SCTP_PAD4 upstream).

So here's a fix for this problem.


Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sctp/sm_make_chunk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1369,7 +1369,7 @@ static struct sctp_chunk *_sctp_make_chu
 	struct sock *sk;
 	int chunklen;
 
-	chunklen = sizeof(*chunk_hdr) + paylen;
+	chunklen = WORD_ROUND(sizeof(*chunk_hdr) + paylen);
 	if (chunklen > SCTP_MAX_CHUNK_LEN)
 		goto nodata;
 
