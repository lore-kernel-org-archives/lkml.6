Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227ciTNISfk9PTlaMXoG3x95wrUF8u6ExIqOFq4HcGNFomWooHI23cR8A7v04U1ZP7FwhbMq
ARC-Seal: i=1; a=rsa-sha256; t=1519217129; cv=none;
        d=google.com; s=arc-20160816;
        b=ngaEkyl24FqQc6igjfxGp/ktNTtGta15SQxM1Gl1liSi6LRiVecr8c19jA+vvZjGU9
         u/YeLCTCepl2Pts/DdHBucaUZuxFQyVl7AdYerTvOmw1LhNjzKXEU0dTSAROSlzqRit+
         j2fyJtAgXblml8GiNdXeeJu79rA+OLR8fEPglZAuwDK791uoDX38cyzsl6uA8cgP9GEg
         eR1iuwS5PrMmjmSTKPBTlf+3U8fYUzm8l/m8g9io+RuljAhMRsDW31GZcaSAgXm33op7
         l7/4GMHSQvCRnzupsHonP2CMxSpX0rP7Fzt75uxQZKgWLNoPS0xauq+Qr2WECH81qpe1
         CBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rL02OBrOxOlquNATJUIW/6l4n+rYs5NFV+aZPTvThlA=;
        b=NqGUugcnQUdy14bf/AKJ6Yfx6oJnW72sWbg0fwFNYHi0FkzQPrhgw22wxndfokPDq3
         NfQtXdtrfIWLDB18MnP3VHmjLbtmLkrVCXjBwHVOdOeWaFsWTIStDBhjj8v53QopSSWC
         91BHwOX+KNQg7AF0eJAutjliIuUxLz6S6jR9wp8PGaZekQF8yI4GesTxFkQ8g/44K8AZ
         lKfTrS5hMfSfYGNP9O6GwfvR/1/u9FPlLoGhmMKJUa+g0NuN16SEDQDdjOnOaCoh9hCp
         +NFvhdHaoNtWZNtR2LtcUK0xUNx9jRXgi27EQsNXY6vDQwcv5bUu7tlyL/zRfjnm47l3
         6BRw==
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
Subject: [PATCH 4.4 13/33] ext4: save error to disk in __ext4_grp_locked_error()
Date: Wed, 21 Feb 2018 13:44:56 +0100
Message-Id: <20180221124410.358901912@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014620343797175?=
X-GMAIL-MSGID: =?utf-8?q?1593014620343797175?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -688,6 +688,7 @@ __acquires(bitlock)
 	}
 
 	ext4_unlock_group(sb, grp);
+	ext4_commit_super(sb, 1);
 	ext4_handle_error(sb);
 	/*
 	 * We only get here in the ERRORS_RO case; relocking the group
