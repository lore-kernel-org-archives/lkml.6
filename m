Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AB8JxZrEC9ePpmN4aGpA2cScocurGpUxkb/nTyg8zqC8wD75a1gWxTMOphDO05cLEVZIAo1w+Kiy
ARC-Seal: i=1; a=rsa-sha256; t=1525354269; cv=none;
        d=google.com; s=arc-20160816;
        b=WJPMyOQSFZuasG1wKWdxc0M3J8JDiPozmst0iBPq9YbsTH7r3JE7veDpDWscJVQIQE
         asCjNouhW8ilPm76fF4Tzru80aYKNXMhDsmTUbcGjptC8IWvJcSYTqWtIrWidaIi/WsC
         RJShac0Gjjy54u7Ji2zcwAwYZT2ZOlxRPWz6zv5wZulGCylOp7ZpcbEzQSfvR7YhJVWo
         M/Uq2RSWE65L0f1X9dmS3m2fI//aMZICPDXi6ZUZ6+NUx6sbbC+QaT9ZfhPi8pjrAyKS
         OlZila5ysbeMXxD/y51PVhXkHcPdxo/vWxOpwLtS+byjNs9Egdk49z06bkzST3p9PY5n
         mc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Fg0hRBw+fSisyUHOLItdmMO8JZaOyr1Kr1GA4yKPlcI=;
        b=IQhAF2ML2Nl/eP2cEz5Kil/8yqOmIAtpknOWz3JQefWSHhS+9d52xp0gXo/WIQnUDM
         LUwAtWl9zB4AXOqSv2R6Zzl7wKpOaJHt3bsFCDYcj9J2If3gMrj/JDQX7/ojHv7BDZFI
         LptjEN5XU2Mi+E2hU63pLzgPiltr2pjvwszuX2tMo8+2b1yDCnU1dylhZa6qjO2/C0mQ
         TP4odmX7LFVtsR/sBzxF6ubnxfBPluJhyMHewvz/90AeVMRNKxqRqPfhci9Xa/lguAq8
         WadLQL8XIXOYGFmRPUa1d530AoGyceed80frLBUGYJJGxsXs8icp3PP1uXjWzK14ixeI
         lh8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=gI8NIfbm;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=gI8NIfbm;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
MIME-Version: 1.0
References: <20180503035931.22439-1-pasha.tatashin@oracle.com>
 <20180503035931.22439-2-pasha.tatashin@oracle.com> <CAKgT0UdocfEm9oXZ1dkEMari8m3OA4uVTrYg45uj9fk2V41bxQ@mail.gmail.com>
In-Reply-To: <CAKgT0UdocfEm9oXZ1dkEMari8m3OA4uVTrYg45uj9fk2V41bxQ@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 03 May 2018 13:30:30 +0000
X-Gmail-Original-Message-ID: <CAGM2rea3XXJ7OqGeAdexyOUb1_7W_84t5HAb_hp7Rb=TkTM86Q@mail.gmail.com>
Message-ID: <CAGM2rea3XXJ7OqGeAdexyOUb1_7W_84t5HAb_hp7Rb=TkTM86Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] ixgbe: release lock for the duration of ixgbe_suspend_close()
To: alexander.duyck@gmail.com
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=935
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030120
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599413925684033451?=
X-GMAIL-MSGID: =?utf-8?q?1599449878632538625?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Alex,

> I'm not a fan of dropping the mutex while we go through
> ixgbe_close_suspend. I'm concerned it will result in us having a
> number of races on shutdown.

I would agree, but ixgbe_close_suspend() is already called without this
mutex from ixgbe_close(). This path is executed also during machine
shutdown but when kexec'ed. So, it is either an existing bug or there are
no races. But, because ixgbe_close() is called from the userland, and a
little earlier than ixgbe_shutdown() I think this means there are no races.


> If anything, I think we would need to find a replacement for the mutex
> that can operate at the per-netdev level if you are wanting to
> parallelize this.

Yes, if lock is necessary, it can be replaced in this place (and added to
ixgbe_close())  with something scalable.

Thank you,
Pavel
