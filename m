Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeA3TMt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:12:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35988 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbeA3TMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:12:47 -0500
X-Google-Smtp-Source: AH8x226Ci07qj2I2OX4GpEhVTM3VDHlxkHiBYUdcb5OILjQs2CwW+XO1ZOmKXm+yKwJmWNrKZJvBI2kBnKNFwR+IxXc=
MIME-Version: 1.0
In-Reply-To: <20180130182947.GK21609@dhcp22.suse.cz>
References: <20180130083006.GB1245@in.ibm.com> <20180130091600.GA26445@dhcp22.suse.cz>
 <20180130092815.GR21609@dhcp22.suse.cz> <20180130095345.GC1245@in.ibm.com>
 <20180130101141.GW21609@dhcp22.suse.cz> <CAOAebxvAwuQfAErNJa2fwdWCe+yToCLn-vr0+SuyUcdb5corAw@mail.gmail.com>
 <20180130182947.GK21609@dhcp22.suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 30 Jan 2018 14:12:41 -0500
X-Gmail-Original-Message-ID: <CAOAebxuf_GWZFPzQZs0r5Mgoq-kcDiqd0kpX6yYqC_XqLG+0PA@mail.gmail.com>
Message-ID: <CAOAebxuf_GWZFPzQZs0r5Mgoq-kcDiqd0kpX6yYqC_XqLG+0PA@mail.gmail.com>
Subject: Re: Memory hotplug not increasing the total RAM
To: Michal Hocko <mhocko@kernel.org>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8790 signatures=668657
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=678
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801300234
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You might be very well correct but the hotplug code is quite subtle and
> we do depend on PageReserved at some unexpected places so it is not that
> easy I am afraid. My TODO list in the hotplug is quite long. If you feel
> like you want to work on that I would be more than happy.

You are correct, PageReserved might be tested in offlined memory, if
we go with the proposed solution, we might even need to add "struct
page" poisoning instead of memset(0) in  sparse_add_one_section when
debugging is enabled. Similar to what we do during boot in
memblock_virt_alloc_raw()

The fix would imply to ensure that PageReserved is never tested and
page_to_nid is never executed for offlined memory. I will study for
possible solutions.

Thank you,
Pavel
