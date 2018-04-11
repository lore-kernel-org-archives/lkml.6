Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49xRC3/xPKvxREpI/oVMG4HklLjB2vuMLrEUIL+81zDKk94u8XJ18x84niuSfU1DcZXWMBJ
ARC-Seal: i=1; a=rsa-sha256; t=1523473023; cv=none;
        d=google.com; s=arc-20160816;
        b=GBcOYNw1g6pozH9y1+UzwKY8IighfLhLy/BMHaPPBZM6bFGxqZrsZWP8bXCR4KpwPH
         onvN/iXuEVfenVRMhMThHy/t1sfJXk1xcaR5bdF7yleRdz9enoIJXXPyeh2nPi7Apdq3
         aizJYWyU8sFnLVyfP36GAz+8/Hw9gVu52+sHeVKtu27UkKOgYIuz+o4/pPw6b6zU/dx9
         KGGxrSTEEpbpJ8NiLUCAI7OZiQM8HSxxPFOnmjkTTaKqxhOw3eEwVdyekmcQ+HzKwaYg
         rSRdvfaz4WKtjKsnBy1m93JKhrZMGXDA8JOGdRF77q7HBV/QDAwDN/5xoaH7bsmaKiEN
         x7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IFxB9ahQ/QDYIMv4uQGXixJKag93oduDCiyGWDRWt+A=;
        b=WqddWhecgJ6zZULLZenp+U39bwgM5MFgwLhMHcJqRcBn6phY2I8JO834TdqOn2pWyB
         qmUIvMLSFQ+LxMmNpmMm2+3vRxeJc8qVUfoBx0DAJdxGsmcTc0jmGCOSHnPXLIms6udP
         41rYWTL9kHff/Ap7K7tO2ETmVJKjfkGS+7DarpAyWP1d1umH4XmsjDHdXVH0onz/veAo
         96qguc0rNwXu9AtiyqkafcKUsWsezyZQJl7lO8dRBfqwdGFjWd8kQ2wmz5sFuW5KiLsx
         e0sSBmpvuGBRZGJjuC8fl10G1gFAR1t3nlKd+hTBv9LLYwkk7be/oZqJFAPXLP1W3kMK
         0+PQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 100/310] libceph: NULL deref on crush_decode() error path
Date: Wed, 11 Apr 2018 20:33:59 +0200
Message-Id: <20180411183626.522892681@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476142925384376?=
X-GMAIL-MSGID: =?utf-8?q?1597477249283268954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 293dffaad8d500e1a5336eeb90d544cf40d4fbd8 ]

If there is not enough space then ceph_decode_32_safe() does a goto bad.
We need to return an error code in that situation.  The current code
returns ERR_PTR(0) which is NULL.  The callers are not expecting that
and it results in a NULL dereference.

Fixes: f24e9980eb86 ("ceph: OSD client")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/osdmap.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -295,6 +295,7 @@ static struct crush_map *crush_decode(vo
 		u32 yes;
 		struct crush_rule *r;
 
+		err = -EINVAL;
 		ceph_decode_32_safe(p, end, yes, bad);
 		if (!yes) {
 			dout("crush_decode NO rule %d off %x %p to %p\n",
