Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2275WNu3d2sCx6rkODlgBObYIqxXh6a3DwfxF/fs/COCEcp+XJ9Kk0KnssAQWcFdpFPeJ3pO
ARC-Seal: i=1; a=rsa-sha256; t=1519411091; cv=none;
        d=google.com; s=arc-20160816;
        b=a4eRgLkIL1JAEBZyVReLgn5dXZFHZQCu6mSCdDTI2EXTAalGeE2fTnpim7r7bfXo4j
         RglEgjvXZX24VN3LBroDK212uUDkV4ySSlexZkbTkHC3UERHITEIBIclH7uxMGEareKK
         qfKoVFGrw44x8mrupLHd6ejWBikjfHw+3X4s7k+6uHfrZMFAqWSva+i1bLVGojY6kik/
         UIZOS4krmU5fiJpswPw8Q1653MlEnA4ExfzP3DLuT2MEN/HsEIFQ0M1zVSe/guw02fEA
         bKEKpB21KsLH6Ar3zaIlYsiH3MEBxM94IsuEQJZmsOPYwnVL5VkdJwhY5HR/+YTxjA5m
         bD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GNP5u4Sb6U3Hczn/FU6yzx5WxOS/XfB392p3ItyHc9w=;
        b=LxShbqllhZTcOFOamHnWD1O5v5d3qHMnoDey2AHLfnH5mmFLum1DJYaIrSzZ5/OySw
         kPL2+eip/pigO2awsYR8MHsK/XAw07cs0FHkl6qGgIrg8SVB7c4W76a8BdmUtsAOZ16w
         F4vF9dFy7gYl3bnN0AZ9faDX24bX21MSoMXQqVLQccc9wS6nvb3dUmyGQj47CCKaPWqe
         McEXwOf3WAwRGCBGGabH7kmbyp71dwD1S6SPk31JlRMbg2axg/0Ipq1YAUpKtVgmJBrP
         wRkZAjPBVbpu5t2xFdmaMv05upM56qZFZiDV3NtUXtb6PU04QqJO9JVl2m5o6y+BtCaC
         wJ1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 4.4 080/193] reiserfs: avoid a -Wmaybe-uninitialized warning
Date: Fri, 23 Feb 2018 19:25:13 +0100
Message-Id: <20180223170338.545702896@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218005125191239?=
X-GMAIL-MSGID: =?utf-8?q?1593218005125191239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit ab4949640d6674b617b314ad3c2c00353304bab9 upstream.

The latest gcc-7.0.1 snapshot warns about an unintialized variable use:

In file included from fs/reiserfs/lbalance.c:8:0:
fs/reiserfs/lbalance.c: In function 'leaf_item_bottle.isra.3':
fs/reiserfs/reiserfs.h:1279:13: error: '*((void *)&n_ih+8).v' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  v2->v = (v2->v & cpu_to_le64(15ULL << 60)) | cpu_to_le64(offset);
           ~~^~~
fs/reiserfs/reiserfs.h:1279:13: error: '*((void *)&n_ih+8).v' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  v2->v = (v2->v & cpu_to_le64(15ULL << 60)) | cpu_to_le64(offset);

This happens because the offset/type pair that is stored in
ih.key.u.k_offset_v2 is actually uninitialized when we call
set_le_ih_k_offset() and set_le_ih_k_type(). After we have called both,
all data is correct, but the first of the two reads uninitialized data
for the type field and writes it back before it gets overwritten.

This works around the warning by initializing the k_offset_v2 through
the slightly larger memcpy().

[JK: Remove now unused define and make it obvious we initialize the key]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/reiserfs/lbalance.c |    2 +-
 fs/reiserfs/reiserfs.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

--- a/fs/reiserfs/lbalance.c
+++ b/fs/reiserfs/lbalance.c
@@ -475,7 +475,7 @@ static void leaf_item_bottle(struct buff
 			 * 'cpy_bytes'; create new item header;
 			 * n_ih = new item_header;
 			 */
-			memcpy(&n_ih, ih, SHORT_KEY_SIZE);
+			memcpy(&n_ih.ih_key, &ih->ih_key, KEY_SIZE);
 
 			/* Endian safe, both le */
 			n_ih.ih_version = ih->ih_version;
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -1326,7 +1326,6 @@ struct cpu_key {
 #define KEY_NOT_FOUND 0
 
 #define KEY_SIZE (sizeof(struct reiserfs_key))
-#define SHORT_KEY_SIZE (sizeof (__u32) + sizeof (__u32))
 
 /* return values for search_by_key and clones */
 #define ITEM_FOUND 1
