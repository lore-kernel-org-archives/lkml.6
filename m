Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AIpwx4/EmHV+qoo+TyfpOCVQFwYNIXYOq7L9R54Sr+/icrTp0fpjzHA5RyK1lhQvewsGfGJhmLn+
ARC-Seal: i=1; a=rsa-sha256; t=1522936270; cv=none;
        d=google.com; s=arc-20160816;
        b=VM9NzZvK3Epamab4QxEN8lzd2R6bPdIRFfzMqXxRood4glFCKCr+N7V84L8blQEhA1
         4zCPrARbl7TJpGz/FIHNKhYrZnRzBILCu80HcmPQrxCh/lAfcPIHVk1ezN66KLq4ovto
         y+cK7whUxQxCJGxmx0vWq3PDWn/y2oLw3XSrBC0IoW5imfw2VyVbaKOC9Drii2jsra2N
         SIe0fv0Q7+B7iLS2ucfWRZBla/xfKJtDSE92EvMTXIBopreiDqlnDofXDiv+Dr2k1vhW
         sigdiA7yB5eRayTGH0Hs3/o5H108fbLVGIkWM/9H4vd6Ms0OUn2AE2ERtWxy3EXAnSPQ
         0OCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=KWqBJi11Uja1tC6QedZ9MUskaLGG31f+Cc28470a4Z4=;
        b=gmqw/5FsTEUmgWuRZuxm8SLO8zbG9HP8p0vUFE+ghoSKkPRL94VO483hNEMckyZvhQ
         DgQ70TiPC2F6zTbDcTLGKJ4Pp53iHC9ZzO9kFik7NbDWSm8jJsaNqBQNqtmA02B6gUw7
         gpLLvIDWs17guLc5zJXmRFs/203URcDhH/lmRaoiftBVRDwqSyYdo/IPxm9YOdw/Ua8X
         RkA7W3M5jN/muu/Cw5M63udZoEZV4ERELHxa41SHe1q0CL7dnNb8GL/hYHeIY/8glOVj
         AKyay7h0Ch5x+WvjcfJ+eRt4nZWF6oT5zxX2OnUpWbwwfdRm0Jfzwf/wMVrRHB7h3M5U
         UL7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=aOmZi3pP;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=aOmZi3pP;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Thu, 5 Apr 2018 09:49:40 -0400
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
        "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] mm: uninitialized struct page poisoning sanity
 checking
Message-ID: <20180405134940.2yzx4p7hjed7lfdk@xakep.localdomain>
References: <20180131210300.22963-1-pasha.tatashin@oracle.com>
 <20180131210300.22963-2-pasha.tatashin@oracle.com>
 <20180313234333.j3i43yxeawx5d67x@sasha-lappy>
 <CAGM2reaPK=ZcLBOnmBiC2-u86DZC6ukOhL1xxZofB2OTW3ozoA@mail.gmail.com>
 <20180314005350.6xdda2uqzuy4n3o6@sasha-lappy>
 <20180315190430.o3vs7uxlafzdwgzd@xakep.localdomain>
 <20180315204312.n7p4zzrftgg6m7zw@sasha-lappy>
 <20180404021746.m77czxidkaumkses@xakep.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404021746.m77czxidkaumkses@xakep.localdomain>
User-Agent: NeoMutt/20180323
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8853 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804050137
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591143417186287050?=
X-GMAIL-MSGID: =?utf-8?q?1596914422529813195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Hi Sasha,
> 
> I have registered on Azure's portal, and created a VM with 4 CPUs and 16G
> of RAM. However, I still was not able to reproduce the boot bug you found.

I have also tried to reproduce this issue on Windows 10 + Hyper-V, still
unsuccessful.

> 
> Could you please try an updated patch that I sent out today, the panic
> message should improve:
> 
> https://lkml.org/lkml/2018/4/3/583
> 
> Thank you,
> Pasha
> 
