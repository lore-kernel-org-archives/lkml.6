Return-Path: <dhowells@redhat.com>
X-Google-Smtp-Source: AB8JxZoMnl5VoLAIVilKeZhyC2gqq1HXuZy/tqfxBwMyCQ+dIKmTrWFPTE8CgHuh9yAk9Dsc9kuV
ARC-Seal: i=1; a=rsa-sha256; t=1525102703; cv=none;
        d=google.com; s=arc-20160816;
        b=o36t97zeUSJ+4Cdac9SveN7WkvQzL3B9cCDQtL3fQeSXQHRIXmCv3OI7D8tCEnnQO8
         OFe5vg4G1qDEsOGlbwVdfQQmxhEuT+xIShV6nfubEgkqp3D5bohu3eQ1yfu0Qw0zYl8I
         usgKI2m3/71Ky0mU6RRO076+kNexQY2BndVJ7EpTyFGfChc0RjBpS1t523BkKnNuGXyR
         5NhV53uMKSntjNf0JvYEVM0eWsok+4BYBQMFlX5oeFJzxVC3VxvQCfUidBCFApIj95Tn
         d2KgWunTCDKp9dz5YMrBKrBVB8EkONrc3gFF6QoccEHivk2j5jOMvpuxrN3E2tu/xexM
         VO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:content-id:mime-version:subject:cc:to:references
         :in-reply-to:from:organization:arc-authentication-results;
        bh=b/7zVbEK/29ZMr9M/Ri7K0CoWHshTmTW86XWj1JLH8E=;
        b=OOsnb+kAt5PtkBFjQdn+mVb5kP3VjlrIrmfgP1Tju+zO1694DCyOZpEyjWMluqsqgT
         srGgzy+RiHBYe9/ZSitdkbDPhgY5HZelRx68OBEuqy6eb3Z38K2NAPa/8H8klpK8MGo0
         pkffq6dkfc9B+wQIxasCR0kun5SGk1eNV+V3jLXPnsGhUOJ1YRs/w/RW1ZN0wsKT2Qjj
         DiVEYg3bsLPrJtzxHcEylWcpiHSJXXuVW2gFmHs5Bu1fud4bAqzhj8WZrLK90mns9BVQ
         V+C5FnjJKm2ANTa4ymeM7ZdovrlffBSpIOhaL0EXtJTE3jvucAZ99292B/VTExhpzF5x
         Mnbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dhowells@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=dhowells@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dhowells@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=dhowells@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180425154827.32251-1-hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>, linux-rtc@vger.kernel.org,
    Alessandro Zummo <a.zummo@towertech.it>,
    Alexandre Belloni <alexandre.belloni@bootlin.com>,
    devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
    linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
    linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
    netfilter-devel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
    linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
    megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: simplify procfs code for seq_file instances V2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15621.1525102698.1@warthog.procyon.org.uk>
Date: Mon, 30 Apr 2018 16:38:18 +0100
Message-ID: <15622.1525102698@warthog.procyon.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598733748805898460?=
X-GMAIL-MSGID: =?utf-8?q?1599186092584524528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Note that your kernel hits the:

	inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
	swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
		(ptrval) (fs_reclaim){?.+.}, at: fs_reclaim_acquire+0x12/0x35
	{HARDIRQ-ON-W} state was registered at:
	  fs_reclaim_acquire+0x32/0x35
	  kmem_cache_alloc_node_trace+0x49/0x2cf
	  alloc_worker+0x1d/0x49
	  init_rescuer.part.7+0x19/0x8f
	  workqueue_init+0xc0/0x1fe
	  kernel_init_freeable+0xdc/0x433
	  kernel_init+0xa/0xf5
	  ret_from_fork+0x24/0x30

bug, as described here:

	https://groups.google.com/forum/#!msg/syzkaller-bugs/sJC3Y3hOM08/aO3z9JXoAgAJ

David
