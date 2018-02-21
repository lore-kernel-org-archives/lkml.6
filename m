Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225s2LQUdQopFdPB+vCaGBJrxUbqUmZP98qplayU2vOTYbG8kLwH9cQd/xK3YlPRZXxVO2Ss
ARC-Seal: i=1; a=rsa-sha256; t=1519218391; cv=none;
        d=google.com; s=arc-20160816;
        b=cSXiPiLHT0CLP6BLmeD3qrNvQq1T6s5KHocCO3p+gzuBnx1UWHXwoco9si3EK/wiL1
         NOU6GuuRSrKeE+mh3q6LMAOdb+oXOUGZIEfGli9Ve8nw/W3A82uixLhLx7oQEiWVywaN
         dAIh4hZFAtL+a7zvtTe8lKK2M8Inx8Z07gwn2JFLvZhAZK+7Jx7OleR58FwTCg6P2fTr
         d9WxSgq4RFymW47wJT3E/tEinKV22TPvXK7jxueYVzda7poHn6+kTn2Yj8rFWtD8eipz
         qH3iPm4o7fQTzg/TqqcMUZdaQuwbK3BhiPRqbf6YCK5Af/BZ9NCsQZPi9gn4AiD8gHHh
         6/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PkTcKkMHidUgKY1dXuVy1EiJbPlwQdq4T6Jzpiwm7JI=;
        b=UGNUb7ufK+29sZ6dnt6s48JUfh6XdI+VBkuleq/0wSYNdg8ZSVnOGFNJW8kfvwmSR/
         EkrIiwx+8o3CQW0iL2hEQWVkev1BxyEG+naFhViVYj+aVdwWDlvm8Wt0rnCdicCTsu68
         iU3ON76G22vT4NGl4nVvlYrq8g4jzh0yRCn+3TLf/+4kqyuPJfI4fSL8X1AMXXtzPlGb
         YApKV0z6m3LXjTUmuCPsPa5UEnDiDHnDHjESQIOwnvtrkkXGK7X9+S/JLxPM8v/3wwmP
         pSQMyY9zugavnxEdo+WKXa3IJCYJYKhQNuWn/GcdqDyoeO4MWlOMU/yj+YSOaBAqlPls
         qqFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.15 007/163] IB/core: Avoid a potential OOPs for an unused optional parameter
Date: Wed, 21 Feb 2018 13:47:16 +0100
Message-Id: <20180221124530.367145369@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015484554049351?=
X-GMAIL-MSGID: =?utf-8?q?1593015943781392064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

commit 2ff124d597c2df8696169ce0006fc974c49a4569 upstream.

The ev_file is an optional parameter for CQ creation. If the parameter
is not passed, the ev_file pointer will be NULL.  Using that pointer
to set the cq_context will result in an OOPs.

Verify that ev_file is not NULL before using.

Cc: <stable@vger.kernel.org> # 4.14.x
Fixes: 9ee79fce3642 ("IB/core: Add completion queue (cq) object actions")
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/uverbs_std_types.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/uverbs_std_types.c
+++ b/drivers/infiniband/core/uverbs_std_types.c
@@ -315,7 +315,7 @@ static int uverbs_create_cq_handler(stru
 	cq->uobject       = &obj->uobject;
 	cq->comp_handler  = ib_uverbs_comp_handler;
 	cq->event_handler = ib_uverbs_cq_event_handler;
-	cq->cq_context    = &ev_file->ev_queue;
+	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
 	obj->uobject.object = cq;
 	obj->uobject.user_handle = user_handle;
 	atomic_set(&cq->usecnt, 0);
