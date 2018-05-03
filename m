Return-Path: <morten.rasmussen@arm.com>
X-Google-Smtp-Source: AB8JxZr0JpreXblJra/HyNeCIzkn0XnldV3bLMup+E5Ocfm5zU/JoEg0lMzGl+aKXzEymvSnEIld
ARC-Seal: i=1; a=rsa-sha256; t=1525360382; cv=none;
        d=google.com; s=arc-20160816;
        b=zk4ljCsLKTVj8JgHQnw5oMykvKkaHRJeBZ92BuvCQMT7DfCthQvucsAqBwYSW6iW0Z
         gB5SosOL+2IC2lJwlGzc+tXqhLtmq2hPyL8yWqJ/HWLq5Rxg4s5xm4PT6Xn1reoCoknn
         V6xWq+qH52bBBI5zbsuRhxm5JZSC86ofDJS6YMHATB8euilfFJqjbbg18r2FNIIz99do
         tYaWk02v3LCRMBj7i7YJGFqXqbxHcLo8l/WrelmPyKfy/BM77261+Vnz+V1Aj0hiXWgy
         I2HgLcoPz2D5ad0U2pFIjsSvtsWqAjL1mzuUx351z7Rc7WDDhsKgckB/zdWVvrLrhExh
         IK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=kFhlqmjAN8XThnq4kv75WoxmejmVQnN0zA/GJBOW98s=;
        b=uio8lTteLf3vgw82oCnPkeB1+8yx6JST2qKZucdop2bdHBxF2rZgbbwmoowCfZw0T3
         mXBdgbIryGcrbiCj03tBAYRKeaWHOhzHdbFjR639rD7fXbvbOZJLyrm+WLNE4GVUCPFT
         uJ+8b1VMQOIqUSyWdwF6L3PbPE0wQjYmGCzWjrkg62qBHKbmsMdrTd1nXo/Aq94FIS8D
         Pi0Vxy7ytyXFANdfW+GifOVyMFa15pMHxj51r1D2vR4AaDsFSSAPhMFnNKOqLTq65anu
         AWIYj71dXVGRWwWJaJ6FKhT/qTHyJkbEtKSgNxnqSNYKZPjuOG0h7QlVYrMON5rmV3Gg
         2xtA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Date: Thu, 3 May 2018 16:12:55 +0100
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, Sudeep.Holla@arm.com,
	linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com,
	hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com,
	Catalin.Marinas@arm.com, gregkh@linuxfoundation.org,
	Mark.Rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org, ahs3@redhat.com, Dietmar.Eggemann@arm.com,
	palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com,
	austinwc@codeaurora.org, tnowicki@caviumnetworks.com,
	jhugo@qti.qualcomm.com, timur@qti.qualcomm.com,
	ard.biesheuvel@linaro.org
Subject: Re: [PATCH v8 13/13] arm64: topology: divorce MC scheduling domain
 from core_siblings
Message-ID: <20180503151255.GB28409@work-enc>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-14-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425233121.13270-14-jeremy.linton@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766330955487456?=
X-GMAIL-MSGID: =?utf-8?q?1599456288836095881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 06:31:21PM -0500, Jeremy Linton wrote:
> Now that we have an accurate view of the physical topology
> we need to represent it correctly to the scheduler. Generally MC
> should equal the LLC in the system, but there are a number of
> special cases that need to be dealt with.
> 
> In the case of NUMA in socket, we need to assure that the sched
> domain we build for the MC layer isn't larger than the DIE above it.
> Similarly for LLC's that might exist in cross socket interconnect or
> directory hardware we need to assure that MC is shrunk to the socket
> or NUMA node.
> 
> This patch builds a sibling mask for the LLC, and then picks the
> smallest of LLC, socket siblings, or NUMA node siblings, which
> gives us the behavior described above. This is ever so slightly
> different than the similar alternative where we look for a cache
> layer less than or equal to the socket/NUMA siblings.
> 
> The logic to pick the MC layer affects all arm64 machines, but
> only changes the behavior for DT/MPIDR systems if the NUMA domain
> is smaller than the core siblings (generally set to the cluster).
> Potentially this fixes a possible bug in DT systems, but really
> it only affects ACPI systems where the core siblings is correctly
> set to the socket siblings. Thus all currently available ACPI
> systems should have MC equal to LLC, including the NUMA in socket
> machines where the LLC is partitioned between the NUMA nodes.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

This patch looks good to me.

Acked-by: Morten Rasmussen <morten.rasmussen@arm.com>
