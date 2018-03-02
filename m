Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu8DuZoE211TD0QRi13EGTl3HMXrbjpPHvgDopKlLV6ExStgBzVilpw+PLbQq8q+0TsGQ3h
ARC-Seal: i=1; a=rsa-sha256; t=1519981131; cv=none;
        d=google.com; s=arc-20160816;
        b=BWOwE1mwGg6CJvEKeul8Tqqu00YecMvzcpssNUaGq+kgY2ApMi17udqSyfkt2Feg2H
         uXj9aWhUJcN7wXkWKBufG+R2+Om0BI8JPRowsqD2IpcUqJmQMkjrTP1+m7F3VJxhwuSB
         n/tdXMA7VMSKVeTcCfNCI0PjCB3q+iCtSSLfB35f0ZEK1Q8uQuR57E8nQ+Cej1FfVc7c
         Rkh5Dkx2R4KMLGVFNP5AXjfupHGdxAMbBF5Ip3vpu/8rxc2ggRxn09f3mlBl8b+2ZW2j
         70c7Aol+YqWBZrgU7kjLmxOnKqVIj/RZm6Ih8oXkgoaJmwWOm4y9F8++HqLAype2Tjhj
         7JDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+QWfXPFnLK+oAvtRVnI9mUiC8I7vp5xr+qNFEsKQUQY=;
        b=ThJvcQ3kXy6mf3sx0tGEf1g/QYKSvwN+sOLnBn2lNVpNscgPVmK7FezcyqI9nYIkHU
         1ElIGfjEKYHqcR2ZkyoYEwQkra1w0EzRQU5yk5xfOLXqH6hTxAZ+1W89wW6VX2tQTRv4
         7ixEOBvK/Rm+zhehkk1P1DakNpPNFxcki/1v2On3kKp5kZzMmhPkhyo4uf4KHnC1MVE0
         EndGysoDF/c7doh19v/kX3eRjL5kUP8UaummVT2Z0XHXCQimbu0nMcQMPpGecQbULbCq
         tVyXzzGBxuR4MD7m1mU9RO5PYNnUkU+otiR5HuHhUSIu0cejj93atkT72vsC3BzvajNY
         8DBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ross Lagerwall <ross.lagerwall@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 51/56] xen/gntdev: Fix off-by-one error when unmapping with holes
Date: Fri,  2 Mar 2018 09:51:37 +0100
Message-Id: <20180302084452.115518535@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815399059107290?=
X-GMAIL-MSGID: =?utf-8?q?1593815734225955061?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Lagerwall <ross.lagerwall@citrix.com>


[ Upstream commit 951a010233625b77cde3430b4b8785a9a22968d1 ]

If the requested range has a hole, the calculation of the number of
pages to unmap is off by one. Fix it.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/gntdev.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -378,10 +378,8 @@ static int unmap_grant_pages(struct gran
 		}
 		range = 0;
 		while (range < pages) {
-			if (map->unmap_ops[offset+range].handle == -1) {
-				range--;
+			if (map->unmap_ops[offset+range].handle == -1)
 				break;
-			}
 			range++;
 		}
 		err = __unmap_grant_pages(map, offset, range);
