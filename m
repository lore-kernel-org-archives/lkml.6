Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Ixtl1W7T8ZCcibGTs2oQDKU12Vi90gzFOBmLgJ58v8rr36dcaLoH4x/Tuv2bTWBbxp3R+
ARC-Seal: i=1; a=rsa-sha256; t=1519217941; cv=none;
        d=google.com; s=arc-20160816;
        b=jjRkA7Csf6DFj76rYx1nPdS5GKL+abj7Ff6jsH8HnU6vGv48aAAyO0edJsFLOn6q7m
         D08diMyRXKApOKpeSzUxc0eK1RiKrZeWoVcKOvXSILMctCMiHpnQbg602cZANfehoioc
         E4w5k44Rc2RVl2HIM699mu94KnB7d5bm9xtePKxSwmrJmdEj87XP327tTdLCYua7zLBH
         eZRuLqozYvUBVY4LlNr1ScgOBy7ZSM/TdTrYUIJlFsc1E+DThceQPu2gkrxU5Lij8lvO
         nUsEoHWvOgiJ1G5AkJX+Kw/7HdC4mITXvXSbjg1qCYBEPC/2gUWX7B8zWtCxA/WVT9CC
         8u5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WzxRa4jOFXKoz3akqAi7X+9IesgJWJLBBYeIsQdUpvs=;
        b=GGBSB+PhPjlSg5oHXlhTRROxcIJ/krlQ5d+yHQEZjruhdISOpiCeccihE1F8hvmQwW
         m8OudBmegNoVk29wngacozKBtSu0XQl+pcuaoVym85xGqkwnsO1zphI+qAYgR3mjYUDM
         tCu4rJ0FMfpnD2gMgrKdNo/wNZtTXdFERzdMZ3WPlgbrOItaulYUdVrH/QVjkzLOK/4v
         yfORjxW7Rmm+it5EsS5Epdn4K0ciKJcEY5ZtOwF3W9qKhcS5k/5s3QkcebjNDZeXt/65
         EwQHe/ICPnpFOqqPQylomXFgXx0eQWpd7x0SLS60OK9kKhpag2wUfOCf+Ruialgw+ESA
         petA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 004/167] IB/qib: Fix comparison error with qperf compare/swap test
Date: Wed, 21 Feb 2018 13:46:55 +0100
Message-Id: <20180221124524.874583902@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015257383542372?=
X-GMAIL-MSGID: =?utf-8?q?1593015472000029540?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

commit 87b3524cb5058fdc7c2afdb92bdb2e079661ddc4 upstream.

This failure exists with qib:

ver_rc_compare_swap:
mismatch, sequence 2, expected 123456789abcdef, got 0

The request builder was using the incorrect inlines to
build the request header resulting in incorrect data
in the atomic header.

Fix by using the appropriate inlines to create the request.

Fixes: 261a4351844b ("IB/qib,IB/hfi: Use core common header file")
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/qib/qib_rc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/qib/qib_rc.c
+++ b/drivers/infiniband/hw/qib/qib_rc.c
@@ -434,13 +434,13 @@ no_flow_control:
 				qp->s_state = OP(COMPARE_SWAP);
 				put_ib_ateth_swap(wqe->atomic_wr.swap,
 						  &ohdr->u.atomic_eth);
-				put_ib_ateth_swap(wqe->atomic_wr.compare_add,
-						  &ohdr->u.atomic_eth);
+				put_ib_ateth_compare(wqe->atomic_wr.compare_add,
+						     &ohdr->u.atomic_eth);
 			} else {
 				qp->s_state = OP(FETCH_ADD);
 				put_ib_ateth_swap(wqe->atomic_wr.compare_add,
 						  &ohdr->u.atomic_eth);
-				put_ib_ateth_swap(0, &ohdr->u.atomic_eth);
+				put_ib_ateth_compare(0, &ohdr->u.atomic_eth);
 			}
 			put_ib_ateth_vaddr(wqe->atomic_wr.remote_addr,
 					   &ohdr->u.atomic_eth);
