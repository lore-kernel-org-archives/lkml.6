Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48+9QzTUUfJG5jQNcLPiE18eRtf/Mm16Mh1ZuGnLyQVJJm6Z5b6j8pYJiXcx0XKH0hirTSA
ARC-Seal: i=1; a=rsa-sha256; t=1523981079; cv=none;
        d=google.com; s=arc-20160816;
        b=YjkpVoEGu6dnSxAEq0KuDJ3DGob7Sc2Vn4GHRQYqaXrwo2pN6wAwT0ApHaGT0SDXiD
         nlqXIpiTPjuy2UIAgwQfat9PnH3tKN6va60iw4UY2BVND0s3eKjr9Kqa2N4eIRhp1AZu
         H8IToF1nlVothue2uA/BcrnKFV+6OnivfVbm7kwiwrdqjn3EQqrixe4xwk5ohIZHzGDU
         ogZKg52wjtVClEz5l0mSlUNtVQz2P3GMDwY2U2lfjE44dXSZ4GG4ETfIBNa233APBEnr
         fjGV9tRNlhAtC6lRv+qxmFf7jVk37PtRQ/JOPjX+y/1sjn9/uj1Uf2vjzg+TKkGyUi4S
         WrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=brWdCMXzEciKPNuaiojosu9+e2OZXdmshk8Iwm98ukE=;
        b=oDRMw1/IMdl23PYJWOwGDTfOpVKXxQyVPtIbs8lF/5FUq6EPgOHZyrGrXzWB+PXqQx
         fZRcjqPk/BDwsPakFXaaAZl9efK7E3Vc+m1ALDOYej/eRpa2orPi4MafQNBoNBQHGtlY
         jh/U2OULjUwQ9k/NKXdlweQJiG/GQUhOGtWDAOq8BXRIDteduOzAfdzaaDnzCCyDFH3Z
         P7y6JCCfi+UADE/cr42LogT0Lq4/VsPR+C7LwCdT461YxomczEeMi8JQiWc+I/ccJQNI
         MwiCkj1Ioj5VIzFZtsxq4Dx5dLgNkwq+TX0vT4OrqyaN/e9xiu+CsrlaOFPXDm5gqPsz
         CxoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Serge Hallyn <serge@hallyn.com>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 4.15 39/53] apparmor: fix display of .ns_name for containers
Date: Tue, 17 Apr 2018 17:59:04 +0200
Message-Id: <20180417155725.021110829@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009831116787143?=
X-GMAIL-MSGID: =?utf-8?q?1598009984583393643?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

commit 040d9e2bce0a5b321c402b79ee43a8e8d2fd3b06 upstream.

The .ns_name should not be virtualized by the current ns view. It
needs to report the ns base name as that is being used during startup
as part of determining apparmor policy namespace support.

BugLink: http://bugs.launchpad.net/bugs/1746463
Fixes: d9f02d9c237aa ("apparmor: fix display of ns name")
Cc: Stable <stable@vger.kernel.org>
Reported-by: Serge Hallyn <serge@hallyn.com>
Tested-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/apparmor/apparmorfs.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1189,9 +1189,7 @@ static int seq_ns_level_show(struct seq_
 static int seq_ns_name_show(struct seq_file *seq, void *v)
 {
 	struct aa_label *label = begin_current_label_crit_section();
-
-	seq_printf(seq, "%s\n", aa_ns_name(labels_ns(label),
-					   labels_ns(label), true));
+	seq_printf(seq, "%s\n", labels_ns(label)->base.name);
 	end_current_label_crit_section(label);
 
 	return 0;
