Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224CPDGPWJoohhuZXN906Kgx0mjrqwMFjH5/6RxTUyFXvpyV90auCxFlGeoKI5bupRoL9QGE
ARC-Seal: i=1; a=rsa-sha256; t=1517591143; cv=none;
        d=google.com; s=arc-20160816;
        b=B2fRjfNyihf7UcLx3361m1GgAL5j8Ms7iR/xu9o8eB6geVTN66SttacqqE4xXaVptl
         0ia2sSDD/Bpir6Uw4VOT6EXzcKA7stCtsyJJ+UY3bPCAFvUUqlY9Ufi/+L5PYPnySimI
         BIibCHjI4rrYnwMGroFrxcxpAmqAXTSWjGSzF2PtEP+CmbtYgRNyB7mKxpiOuMfV7M8Q
         wNjs/96dJwPSIgsiZiHGQOimKUBo9l3rZDimtg/kuveu6eMUdrEVUFN7f8Odm/I/QaFe
         NYwhBilgFQkPoczYYxYaThEwM6eev+2VOjy/jXTr1RbjelIVUVDv3PS8B9aMX4xjJbf2
         OMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pJO2YoNS0t40sxDws2oiypI324NATcc7hFAqxqlgwSU=;
        b=OX9OhtQHQZzUjena58TqBEnQ274bgsJtHbknURCQU4BgbxIuASNDLl01bEVYA9xwEh
         YovNPo9/acOx9peN673ifBK1TnXVDnu4B7eLGLI7NNC4VpfuLr/XTlUlYWGiUDaPX+eP
         3LqUM63IIMgBKpSjU/lzFi64nJ9qNVUSL9z2329B37GdtlFZIVqF4Ce+G45Kf91TOetr
         9zo3CuGNp0i+aQ7IUkTQsbS3u8K2Sb7FqwnxyVnD+qtms5cCsLlb9kurDBfd+KL+spIG
         Hvx+ROsagvvlsdCD0SHO3SQRwiz47r7IMusVenDpHQb7AIjF5EnrX8WqW1xUPaHIohz7
         EQPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 49/86] drm/amdgpu: dont try to move pinned BOs
Date: Fri,  2 Feb 2018 17:58:09 +0100
Message-Id: <20180202140826.759017123@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309650985590160?=
X-GMAIL-MSGID: =?utf-8?q?1591309650985590160?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Christian K�nig" <christian.koenig@amd.com>


[ Upstream commit 6edc6910ba4cd6eab309263539c8f09b8ad772bf ]

Never try to move pinned BOs during CS.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -416,6 +416,10 @@ static bool amdgpu_cs_try_evict(struct a
 		if (candidate == lobj)
 			break;
 
+		/* We can't move pinned BOs here */
+		if (bo->pin_count)
+			continue;
+
 		other = amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type);
 
 		/* Check if this BO is in one of the domains we need space for */
