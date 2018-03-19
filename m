Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuaEQALIb78QwI4BwXJQdYndbkNh4iiFPnnuIWPXTeJSolmhqMzkaMQoD4CJEy6IW+S1zwu
ARC-Seal: i=1; a=rsa-sha256; t=1521483693; cv=none;
        d=google.com; s=arc-20160816;
        b=I/FajWmBwyW9XqeQjOtuO3NVQfjBxqHUGEkI2ISFVf/40V3bGawjE4itWujU5IgPXb
         0qEpkwcKjdHfH2Cz0t+g8tzu6Ul5XPGaYRxtFe9TJEYFPXZSh5as1fp5ZFZFoWDSUr61
         h8XQmFg8ntv0JMLp5SZvBcM+0DOO3+7r+igKjrEF9luJV6yymtnIjv1jxQ2CPJ3/0Nsc
         rwcinV96yikKX4raTdr6E75cr+dKpCnkSobIoIF9qcX/SVvCBAeGi+MaoFfmyLj+gvHk
         4bSlJdStcLeK2yXqNjsL7hzNDGfyQ8VTuHlIJh8CfIUBuqvR7931xExKIGSAhXDIYcgj
         EPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IvyYWFmbopNw8zTnEfdCGbOwWtNcoe9+panq6O/QAgU=;
        b=Sc7ixf5KwGaSnfrlQLCdlAN1rgx88InltpiQScvw6jSu9ZLa0cJzyB+yL7Ce6sW705
         7dFPEtvglmRo/JuEWHIQ70QW69G63SpQ4X6eoiUe0RG6GCPwr2zd1S6Cc8wJJ9S0FKUC
         5MoHK4Ix/s9XbJiP92WXdoFHg4ntyArG3MfUsVhOw9GgxpToAsDngVTXHM3/xufNu0wE
         CmBcT0gz3UKOyYjtCvJwip+4uiQW8vqAruJc9TJFUMHW0jTzue8vXP0aNVAKjFH7EAEQ
         l/CdPNTBikGccv4gvqBFkD5hTcqRlu5FoKsKFFQIzdMtasFWps0m3h2bUQWWLr4EaHt9
         SVDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yunlei He <heyunlei@huawei.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 082/241] f2fs: relax node version check for victim data in gc
Date: Mon, 19 Mar 2018 19:05:47 +0100
Message-Id: <20180319180754.596539198@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390871217961883?=
X-GMAIL-MSGID: =?utf-8?q?1595391285044369195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>


[ Upstream commit c13ff37e359bb3eacf4e1760dcea8d9760aa7459 ]

- has_not_enough_free_secs
node_secs: 0  dent_secs: 0  freed:0  free_segments:103  reserved:104

          - f2fs_gc
             - get_victim_by_default
alloc_mode 0, gc_mode 1, max_search 2672, offset 4654, ofs_unit 1

                - do_garbage_collect
start_segno 3976, end_segno 3977   type 0

                  - is_alive
nid 22797, blkaddr 2131882, ofs_in_node 0, version 0x8/0x0

                   - gc_data_segment 766, segno 3976, block 512/426 not alive

So, this patch fixes subtle corrupted case where node version does not match
to summary version which results in infinite loop by gc.

Reported-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/gc.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -538,8 +538,10 @@ static bool is_alive(struct f2fs_sb_info
 	get_node_info(sbi, nid, dni);
 
 	if (sum->version != dni->version) {
-		f2fs_put_page(node_page, 1);
-		return false;
+		f2fs_msg(sbi->sb, KERN_WARNING,
+				"%s: valid data with mismatched node version.",
+				__func__);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
 	}
 
 	*nofs = ofs_of_node(node_page);
