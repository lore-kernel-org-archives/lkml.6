Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/JedDOHod2bzs2b/zkcY/Sz4BrUUXUtodIIMJkaXsomECAcEf8ljENo4hR9dd1nHSNA6ix
ARC-Seal: i=1; a=rsa-sha256; t=1523021423; cv=none;
        d=google.com; s=arc-20160816;
        b=MpY6Kp6eyajM907X3jaUX5zcvAZFeURh8/HCk95bDC9eScNvER8/SenuiOONo03EQA
         HhI0A/fVmYr6yNXF1/Sth3TGuiZD69uchhBI+VlJxWzC8Eg+gk1Z+jnx+avzXZ7HqY6x
         6AtCpcuN0LIa4Lo/EWBE6FQjQsH2Y7fpQ4OCbb7z6yYo6m+CDhrr5eerfy60C5vQ7fCA
         Y3rcyRIvLbVvXtCAroCYM8qYni/deS72D5Hm6V1hT++cLhtg78T33hW1YBCyrOb+OUA8
         RoT4AQv6A+35mvZ+t/50Cn7sys0RwKC8ZQFe0iw8+aAXtyQMSDor9QY68RN+1nH4ydJp
         Gchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bo6umB6P4WhD3qaVP2VVDeBtyagZaG+ncNnbAApo4pU=;
        b=DV4vPT+9Rp3BErOajR/md7zsP0deESU4IDfvIy6DQ3BRP3ctgMrlVaonVeyqIoj3fQ
         b3K1tAU7ztaQyX/v7rzeL9VJv1WaBx9DphXDZvxGu/aK9vAFk5GiFid/Sq9vrdSz17RE
         XMrFXftfnC1xSWKblnaXUmQyXIz2cnwe+Ai44t7h5hUMggYtwyPtOp41z6qRJ1VmdzsU
         dJedkiV1QEHJRR8tStdoKBbHVhBb7XH/n5gCg7bmBaRq3h6nh3xhWcAV6wn+xCrxakEn
         TACgGKOJruuqBIECQwgZQtpbGGEXC4/gONeNrGH7eX1N+2UkANYTOqFfW8+BWn3ZTPpB
         lxkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kaixu Xia <xiakaixu@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 13/72] writeback: fix the wrong congested state variable definition
Date: Fri,  6 Apr 2018 15:23:14 +0200
Message-Id: <20180406084306.160058817@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003712224018998?=
X-GMAIL-MSGID: =?utf-8?q?1597003712224018998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kaixu Xia <xiakaixu@huawei.com>

commit c877ef8ae7b8edaedccad0fc8c23d4d1de7e2480 upstream.

The right variable definition should be wb_congested_state that
include WB_async_congested and WB_sync_congested. So fix it.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jens Axboe <axboe@fb.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/backing-dev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -922,7 +922,7 @@ static atomic_t nr_wb_congested[2];
 void clear_wb_congested(struct bdi_writeback_congested *congested, int sync)
 {
 	wait_queue_head_t *wqh = &congestion_wqh[sync];
-	enum wb_state bit;
+	enum wb_congested_state bit;
 
 	bit = sync ? WB_sync_congested : WB_async_congested;
 	if (test_and_clear_bit(bit, &congested->state))
@@ -935,7 +935,7 @@ EXPORT_SYMBOL(clear_wb_congested);
 
 void set_wb_congested(struct bdi_writeback_congested *congested, int sync)
 {
-	enum wb_state bit;
+	enum wb_congested_state bit;
 
 	bit = sync ? WB_sync_congested : WB_async_congested;
 	if (!test_and_set_bit(bit, &congested->state))
