Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226YDg8+3ZrnuRNoJbXoq5TgdMsi/YBRCAtgyiDcrcqUIRHBofqXAUtErjO8IhuMTFMK04Er
ARC-Seal: i=1; a=rsa-sha256; t=1519217683; cv=none;
        d=google.com; s=arc-20160816;
        b=u4VN6Sj99R/+8eIW1Q2KRWByzkUtFGPxheq0wPXd3T5bmMxWa8dsf3JTIUQOAPk3id
         keqCeFYYJKdkze+Oxkw3pIJGIYvzXs2fNiTLhrFWPZvuumAVzIE0CN+dEGsDvSVDQKv3
         tJj5v0BlZcwqDpEIyZUNn8RzaU9Tcw+9Y4FkqFzhHTVDEOB28GpEYXKklfdpe9j/PjEN
         Uj2MNfmc2yv2puYjsIPm5MC7ET32/vOd63tZOzPjCsccoZUIHC8U7qqKrKH78MrireQl
         za3GMVz74LvecrNsK3SpBG44Ocr48MUHzDXZsxwDNDlULRYSp8TumlDiU8lpkYC8Jegf
         AR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5apjAbXwDBR79CGRv0uuAgxM6nOl/NiOHfT/zZxTca8=;
        b=xvAa1O5ChU1siGvUkAkae76cr378VUknNjjGbOhAVsTR2xYhr3VYPkUyvYe/B68lRl
         f2l1D/P3KLA5G9B1LhXYpiETsLg0GZoaIwvswZ9F10RkGerFUFxAE/BdvDuKKr8E2XPg
         E3TcMdrTmsexk75y3cIOraPZC8Jg3SxFOzrbDKFHEaIK0mir2GO3O3Or4BpY5Ch8XmBt
         dl7WncCh/+QLWY9ztQpW/zAXGSr0GigQtsjKbgORmEO6/4kuar0J/JF7ik1xqBOPmI3b
         cYfLQdXH4x67pwW6liV81e+P6LE7//fRmkquXgjepjNWd9KOrTXZVtXXpvixq17jMikX
         gjOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liu Bo <bo.li.liu@oracle.com>,
	Josef Bacik <jbacik@fb.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 18/77] Btrfs: fix deadlock in run_delalloc_nocow
Date: Wed, 21 Feb 2018 13:48:27 +0100
Message-Id: <20180221124432.950380626@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014637413119175?=
X-GMAIL-MSGID: =?utf-8?q?1593015201831797698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

commit e89166990f11c3f21e1649d760dd35f9e410321c upstream.

@cur_offset is not set back to what it should be (@cow_start) if
btrfs_next_leaf() returns something wrong, and the range [cow_start,
cur_offset) remains locked forever.

cc: <stable@vger.kernel.org>
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1320,8 +1320,11 @@ next_slot:
 		leaf = path->nodes[0];
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
+			if (ret < 0) {
+				if (cow_start != (u64)-1)
+					cur_offset = cow_start;
 				goto error;
+			}
 			if (ret > 0)
 				break;
 			leaf = path->nodes[0];
