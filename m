Return-Path: <marmarek@invisiblethingslab.com>
X-Google-Smtp-Source: AB8JxZruPMFOnJvLA6n++/3rhXKrKjYDv27pa7BS42BQ2TuVo1o08wjYT+nAFdhbFKmQN7skFHu6
ARC-Seal: i=1; a=rsa-sha256; t=1525122177; cv=none;
        d=google.com; s=arc-20160816;
        b=upjHzupvTKvBxwHeP4puXLkjExk8SzNhhZTWEKo9bp2aUhSnkRsLqAjajZaSa7d3EY
         +4igKHHsz0horqheVDA1h7423RaCX+vmGjY6P/GzZI3PHUTqVHtBCz0VgbijTWDMpa1Q
         uZ1rZOi0VxgSnBjb63985g0yJemF4yvSx96VPdHduEZtXAX1OuiGHoZzjTANXH6f4A5r
         GBc8rmH8/nli4RNoVFWOlqnXYH5zfjZo9jeo4zfUCs4ocLPoynIzd4ueYmUckTEVMslV
         Tog2TvQO3J2X0J+YQOTeIYmxslpqbdzbYX4283tw9zeT4BTz8ndXQ5mjIBx84vFiObih
         dHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=S9cQcy7oo3wuf0PQ2uX/yL+izb/L4Cv3J7jKhZs2aiI=;
        b=lh2mO+CKyFKk7Myau5sjxtVta4I0fumdqZFPKh3MkccfmTjHNZqA1f6utDstOKtThu
         zQMC3VBHpvQe54Qth9i+ROXBE17qZ/h85W/ZPUQnHW7RunuDhjFscMtGSx6RVtVbSJYJ
         4gFRPS9cmQXB6LfnamXI8ysh5o6cJifuXgFZppofgSEBiy+RwfvxvhdPtNss0AGRBF8p
         7yBqrJWuVSUp7prKrgjFNS8DyNOMoytK1AsMSNOuIpilpTYESdzBaxbHSqHJTrgiDprH
         K6gm/oZ+F93yX535RvgbG+BOhZUfV2OhrLEmTF3Hs8dUdu5rlZTZ8wIZu82IW9QI6lX4
         d3dA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=YLpZII6p;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of marmarek@invisiblethingslab.com) smtp.mailfrom=marmarek@invisiblethingslab.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=YLpZII6p;
       spf=neutral (google.com: 66.111.4.26 is neither permitted nor denied by best guess record for domain of marmarek@invisiblethingslab.com) smtp.mailfrom=marmarek@invisiblethingslab.com
X-ME-Sender: <xms:gITnWiSt5J0N72mbrUMvjH9pYdWVNBMgoypMrXXa_Is1d19ZmjwF8Q>
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: xen-devel@lists.xenproject.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Juergen Gross <jgross@suse.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	stable@vger.kernel.org
Subject: [PATCH 0/6] Fix XSA-155-like bugs in frontend drivers
Date: Mon, 30 Apr 2018 23:01:44 +0200
Message-Id: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599206512045646280?=
X-GMAIL-MSGID: =?utf-8?q?1599206512045646280?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Patches in original Xen Security Advisory 155 cared only about backend drivers
while leaving frontend patches to be "developed and released (publicly) after
the embargo date". This is said series.

Marek Marczykowski-Górecki (6):
  xen: Add RING_COPY_RESPONSE()
  xen-netfront: copy response out of shared buffer before accessing it
  xen-netfront: do not use data already exposed to backend
  xen-netfront: add range check for Tx response id
  xen-blkfront: make local copy of response before using it
  xen-blkfront: prepare request locally, only then put it on the shared ring

 drivers/block/xen-blkfront.c    | 110 ++++++++++++++++++---------------
 drivers/net/xen-netfront.c      |  61 +++++++++---------
 include/xen/interface/io/ring.h |  14 ++++-
 3 files changed, 106 insertions(+), 79 deletions(-)

base-commit: 6d08b06e67cd117f6992c46611dfb4ce267cd71e
-- 
git-series 0.9.1
