Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2255PNiVwIZRQFapTh7F/OOKajqexh3mxKffSfLzGXV2tFw2uV+wkNIKSR/LMkZiZUBHDWXP
ARC-Seal: i=1; a=rsa-sha256; t=1519218656; cv=none;
        d=google.com; s=arc-20160816;
        b=gt1p1+CcKfeeNpwAyBJmOD17vaDVJOOljsSSbKGuNIkiOatETbVQUgnhSfFFj0cgiZ
         4e2LuHseeUc8fGZAgFILM3i7yxdISCiOGqp80cm0toAKG/9Yq9aiRq7XUX+pN2u4r3tm
         /C9a/PlgCTgdoswvbvtQAhyyiHG6fIaMVX0o7y6KcyZKrDSXCXBDfSfELUEkZwmSiSKw
         IvuReB7N9NsTfBJ46SLD0O23OxmmvUKPR8CkDtqPDVezX8JdHbYV6+PJrbSFoLHPVBOH
         RP2OTrkRgJlsaz1s7/e+U5YR65y4a+SBiJyHqZg3aVVsMMEe9wnikg/CPz+wCy2b7qmZ
         dakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P+7Xs2ChQ7oHVpCqhnQcAEq9nouksJ/0W2l1ck2Gbos=;
        b=Dbsx2a/WsF6Sm0NwdJiBIOtr3thQWZRgBHbxvCmB/tbx6bsv/uFwhlvqm5H/4EcIGr
         wNqD4Qpl9BSpWEz1tsRiRXSKTHOtAA01R8YLhJxzs2PoadLPoNuEW4vM1Sa++b1tM9GR
         RDpQLcnAisJtru5yopixQ4o8W0b9qnaai36g7pA6j14gjytqNNUsACwRkgUBPp9AnXKo
         cjlBWmSxUEdRZy4lWB4/zYHBEgT4oZ9hpk5gtR/+2Y2W/wkokfoEkg9ToMunWpjmlAHX
         4PJ3h70853cwp1Opvu+ixa3JUreR8pT6h95LZOSw5tNjmfRGwfGOZqNpudpvHN3vmor9
         oxXw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zhouyi Zhou <zhouzhouyi@gmail.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.15 108/163] ext4: save error to disk in __ext4_grp_locked_error()
Date: Wed, 21 Feb 2018 13:48:57 +0100
Message-Id: <20180221124536.197167973@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014620343797175?=
X-GMAIL-MSGID: =?utf-8?q?1593016222214138333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

commit 06f29cc81f0350261f59643a505010531130eea0 upstream.

In the function __ext4_grp_locked_error(), __save_error_info()
is called to save error info in super block block, but does not sync
that information to disk to info the subsequence fsck after reboot.

This patch writes the error information to disk.  After this patch,
I think there is no obvious EXT4 error handle branches which leads to
"Remounting filesystem read-only" will leave the disk partition miss
the subsequence fsck.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -742,6 +742,7 @@ __acquires(bitlock)
 	}
 
 	ext4_unlock_group(sb, grp);
+	ext4_commit_super(sb, 1);
 	ext4_handle_error(sb);
 	/*
 	 * We only get here in the ERRORS_RO case; relocking the group
