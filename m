Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuqgupYEF4QQPqG2X5uxaqT5lgbK02EBs6OOd9cbEipyjAFqHVMZysmu3hnxfl+5rsu1G1r
ARC-Seal: i=1; a=rsa-sha256; t=1521214191; cv=none;
        d=google.com; s=arc-20160816;
        b=K6/xNkLcenc6K598UuRJUOhpw7rJuegINr0XhwA77fv7SUo61BwBhFydyJi4VT+CBw
         oHW23Ni566vrqbaOTB9euc+iDixr13zThQhd7axTA3km4K8ssxopglQp+A6Zy24oEjB/
         CqMdjq3Krjpc0n+Iz/7IByUuITI7/ZBb7XkgxSAmZ2D4X9jUuyhFwMOyzzrXbqdHEb5u
         2D6NvrX9uWMVVIh1THup8K3ciHtXjGQF2Smtf5vAcEwyDpGM+THITF/6hc0uWYqXc4Yo
         2i86BRm0Oaub6cccXzw5CXLMw0X0SM0c2YAVqK3VWUUzuG5St0Yayfruuy9tSuFTd2E/
         Uq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EsOdeNCXXWgc2SC1624osEl2Hnuvnnz4KCFO+U8i1c4=;
        b=zVQp6fCqKs8kDYTiBEuVj5rY/RK9RrO8Vlls7nfqODp3bF36gnuq3fBOBZ6NTb3Fpv
         N8uBsJGIj8WmDNUZFRhz6uEAVkd+M4PE3duCYBrbY/BpeqdNgyZYSAif7x+v7XFZuski
         5yefNR3jCAtm3aL43V6ST9/U3TllJEeKpD9vOQ8MMBe1duwLrvltGziPqMOuTo1M16xl
         0QiTzjN8Hipa7ctuPNba12MsMRQUlMmYdjd8KL2/woPIou07p4XudNPIBArM7fc8BHwP
         ZsrrIc1/lU7elLSoeyN+V6vcVY08b/jbuM3Nj/B8t48qYKN8ZlWUgOE0j543/cfNoq6P
         AUsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+a38b0e9f694c379ca7ce@syzkaller.appspotmail.com,
	Leon Romanovsky <leonro@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.9 01/86] RDMA/ucma: Limit possible option size
Date: Fri, 16 Mar 2018 16:22:24 +0100
Message-Id: <20180316152317.275463084@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108499644407287?=
X-GMAIL-MSGID: =?utf-8?q?1595108692475982417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 6a21dfc0d0db7b7e0acedce67ca533a6eb19283c upstream.

Users of ucma are supposed to provide size of option level,
in most paths it is supposed to be equal to u8 or u16, but
it is not the case for the IB path record, where it can be
multiple of struct ib_path_rec_data.

This patch takes simplest possible approach and prevents providing
values more than possible to allocate.

Reported-by: syzbot+a38b0e9f694c379ca7ce@syzkaller.appspotmail.com
Fixes: 7ce86409adcd ("RDMA/ucma: Allow user space to set service type")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucma.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1275,6 +1275,9 @@ static ssize_t ucma_set_option(struct uc
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
+	if (unlikely(cmd.optval > KMALLOC_MAX_SIZE))
+		return -EINVAL;
+
 	optval = memdup_user((void __user *) (unsigned long) cmd.optval,
 			     cmd.optlen);
 	if (IS_ERR(optval)) {
