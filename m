Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224nBGrR/5WXGsGKC7+b1uc8L8nw0tmx+5IzC3ZfmR4ecNjuIEq/mj5njq2Xy2JprSrvbS7H
ARC-Seal: i=1; a=rsa-sha256; t=1519218233; cv=none;
        d=google.com; s=arc-20160816;
        b=Aiw+O3NhuKbxb9rvik5gzXq+xf4LC2jSm54Ur7W2i/ylcToNgRTDvNoblqyqyE30h1
         2YePbUlDK6y+FncbFQ4tKqNVdHy/Bt6jF0UvLRtpond+IFz0wvR+nKfPGuyb7hNwyqJx
         LnuZ9S0pqziUTQ00vm9+A2c2wOaZhrXBZP2hS0VEr1MB86JIK8EnIHL3cty7pIcl8Ju+
         4+LG7osxi53mGzSBufH7gpNATCUAai+1pcZTx+VHPNJ8fuojTiWvbb+XHEfqIG4suQWh
         4Ir243bOKfm5Q0Sge/XrVM3xkOCJi/gbFPWPZiPVaY+UtKpHqX3Q/t7mxY3GvrPMkNMD
         SJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Vdjp4AxEeVrnK+k9eE3TzvcZKPc39zARqtV07LKMWkA=;
        b=d3Rp79PVNTZtjdWNaBuRTnuw+xQDHXFg5SXS3/vQ+b97RR3Qf2q3cKfURaSO0yHprO
         4UW6MLDezOyktWuzyw8brG0RSN/cLch+6wT8p6+USxsmjguN3rA66iZRktkU9XHR+wjw
         mdu/yscj1bqt2KBb0LyxmX9LaKmvjkjn8rPIgC4+fLBF7Xs7JBgjSiD4qr/tvv/PCNY1
         XAIpVHUH7GfhXCpkK6Vp3fLNIeRFE7ulZ1OL0gTYZR2f9kwZ0a04TKuKIVhs1L+90EKr
         6WEycCJNBvKsxrt0uc0iTGbxIyyuF/PKhOYn5mR5viaSd46FiZQAO0Dccc03Rc/GGH6J
         aErw==
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
Subject: [PATCH 4.14 134/167] Btrfs: fix deadlock in run_delalloc_nocow
Date: Wed, 21 Feb 2018 13:49:05 +0100
Message-Id: <20180221124531.961972960@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014637413119175?=
X-GMAIL-MSGID: =?utf-8?q?1593015778930055038?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1330,8 +1330,11 @@ next_slot:
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
