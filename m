Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELss6SYbcFgxxf9vAHBiuz4akOjI6AJZxf0KzN+JIE/b0ZtoRHwSEtBs7c/xSKOCNWmbF8Ck
ARC-Seal: i=1; a=rsa-sha256; t=1521483871; cv=none;
        d=google.com; s=arc-20160816;
        b=SbvNriakNgofWORe8YItz80NTGrQJdiU91jLEkQTY9cU6zT3iGnqqMOZ5vX8/3WVwS
         5XqaVVzegmk4J8UJAxQlgWVzLNVlaoiNrs1crioIRk5aITcQYi2zCKendjEEYaEGM7B9
         OnJOo1YJDPymRkSu4gZ8YR7HmQ8g1b9u75E4tMJlUdeVvDXzP5PRBbgFx/XQT5dRz97p
         +SVS6ez4SHlNnx1wWEI51VtZwwZ5fmPykPnECVE/ksBSzeBU3SfQNUhluhWxb0EtodgO
         V52Ycg3dITrXYXY23Va3/Gc4TK69k7TjytgqW/cON6W0RNhDaf+OVsDwpzXUt3nPw6Jc
         MIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vw7HZgYdJjpQBsz2kbijFgH0lbw8Ud7c+eYxnaBXclQ=;
        b=vPL7lHReDTdgxKQ+sZcQjJRo/v9VoZIG2LHylfhU6UiNqj1ypcYQ3j13bXs/OUBv0A
         Eu7J3uLiKAmJ1wF884evBLqobY1gIYcsvl487oQNuH1qbzMHk+wmgaX4zngJ74PKKDXy
         qToWAbq2GHABnRMONT6jCkwDGTgsQW+evQrUv8geoH7DYbooOQ4yDPOqdP4yFD4dLUgD
         80gdn9GE3L6r3OPFIZJNU/xgluKCQ3XlzHhdJhZj+9OE+e1IINZHFAPEx3fI9f+FY65B
         iZfk5zOszciapR0OK2jSMAzCzsgVRi1zCqkAiszeVes+z1Fz41F5GxyHxyFN21Xb5gxg
         ukdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	David Gibson <david@gibson.dropbear.id.au>,
	Alex Williamson <alex.williamson@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 148/241] vfio/spapr_tce: Check kzalloc() return when preregistering memory
Date: Mon, 19 Mar 2018 19:06:53 +0100
Message-Id: <20180319180757.313717482@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391471715160434?=
X-GMAIL-MSGID: =?utf-8?q?1595391471715160434?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kardashevskiy <aik@ozlabs.ru>


[ Upstream commit 3393af24b665cb0aea7353b05e522b03ab1e7d73 ]

This adds missing checking for kzalloc() return value.

Fixes: 4b6fad7097f8 ("powerpc/mm/iommu, vfio/spapr: Put pages on VFIO container shutdown")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vfio/vfio_iommu_spapr_tce.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -195,6 +195,11 @@ static long tce_iommu_register_pages(str
 		return ret;
 
 	tcemem = kzalloc(sizeof(*tcemem), GFP_KERNEL);
+	if (!tcemem) {
+		mm_iommu_put(container->mm, mem);
+		return -ENOMEM;
+	}
+
 	tcemem->mem = mem;
 	list_add(&tcemem->next, &container->prereg_list);
 
