Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CE6C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A3D240C9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A3D240C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeGEW4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:56:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:41552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753001AbeGEW4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:56:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9AF5DAE03;
        Thu,  5 Jul 2018 22:56:13 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Paolo Abeni <pabeni@redhat.com>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Fri, 06 Jul 2018 08:56:03 +1000
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [4/4] rhashtable: improve rhashtable_walk stability when stop/start used.
In-Reply-To: <86f305ff238d7cdac7ab20b0d6395cc6571cf4e0.camel@redhat.com>
References: <152452255351.1456.12384285355497513812.stgit@noble> <86f305ff238d7cdac7ab20b0d6395cc6571cf4e0.camel@redhat.com>
Message-ID: <87bmblz3zw.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05 2018, Paolo Abeni wrote:

> On Tue, 2018-04-24 at 08:29 +1000, NeilBrown wrote:
>> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
>> index 81edf1ab38ab..9427b5766134 100644
>> --- a/lib/rhashtable.c
>> +++ b/lib/rhashtable.c
>> @@ -727,6 +727,7 @@ int rhashtable_walk_start_check(struct rhashtable_it=
er *iter)
>>  	__acquires(RCU)
>>  {
>>  	struct rhashtable *ht =3D iter->ht;
>> +	bool rhlist =3D ht->rhlist;
>>=20=20
>>  	rcu_read_lock();
>>=20=20
>> @@ -735,13 +736,52 @@ int rhashtable_walk_start_check(struct rhashtable_=
iter *iter)
>>  		list_del(&iter->walker.list);
>>  	spin_unlock(&ht->lock);
>>=20=20
>> -	if (!iter->walker.tbl && !iter->end_of_table) {
>> +	if (iter->end_of_table)
>> +		return 0;
>> +	if (!iter->walker.tbl) {
>>  		iter->walker.tbl =3D rht_dereference_rcu(ht->tbl, ht);
>>  		iter->slot =3D 0;
>>  		iter->skip =3D 0;
>>  		return -EAGAIN;
>>  	}
>>=20=20
>> +	if (iter->p && !rhlist) {
>> +		/*
>> +		 * We need to validate that 'p' is still in the table, and
>> +		 * if so, update 'skip'
>> +		 */
>> +		struct rhash_head *p;
>> +		int skip =3D 0;
>> +		rht_for_each_rcu(p, iter->walker.tbl, iter->slot) {
>> +			skip++;
>> +			if (p =3D=3D iter->p) {
>> +				iter->skip =3D skip;
>> +				goto found;
>> +			}
>> +		}
>> +		iter->p =3D NULL;
>> +	} else if (iter->p && rhlist) {
>> +		/* Need to validate that 'list' is still in the table, and
>> +		 * if so, update 'skip' and 'p'.
>> +		 */
>> +		struct rhash_head *p;
>> +		struct rhlist_head *list;
>> +		int skip =3D 0;
>> +		rht_for_each_rcu(p, iter->walker.tbl, iter->slot) {
>> +			for (list =3D container_of(p, struct rhlist_head, rhead);
>> +			     list;
>> +			     list =3D rcu_dereference(list->next)) {
>> +				skip++;
>> +				if (list =3D=3D iter->list) {
>> +					iter->p =3D p;
>> +					skip =3D skip;
>> +					goto found;
>> +				}
>> +			}
>> +		}
>> +		iter->p =3D NULL;
>> +	}
>> +found:
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(rhashtable_walk_start_check);
>
> While testing new code that uses the rhashtable walker, I'm obeserving
> an use after free, that is apparently caused by the above:
>
> [  146.834815] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  146.842933] BUG: KASAN: use-after-free in inet_frag_worker+0x9f/0x210
> [  146.850120] Read of size 4 at addr ffff881b6b9342d8 by task kworker/13=
:1/177
> [  146.857984]=20
> [  146.859645] CPU: 13 PID: 177 Comm: kworker/13:1 Not tainted 4.18.0-rc3=
.mirror_unclone_6_frag_dbg+ #1974
> [  146.870128] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.1.7=
 06/16/2016
> [  146.878478] Workqueue: events inet_frag_worker
> [  146.883433] Call Trace:
> [  146.886162]  dump_stack+0x90/0xe3
> [  146.889861]  print_address_description+0x6a/0x2a0
> [  146.895109]  kasan_report+0x176/0x2d0
> [  146.899193]  ? inet_frag_worker+0x9f/0x210
> [  146.903762]  inet_frag_worker+0x9f/0x210
> [  146.908142]  process_one_work+0x24f/0x6e0
> [  146.912614]  ? process_one_work+0x1a6/0x6e0
> [  146.917285]  worker_thread+0x4e/0x3d0
> [  146.921373]  kthread+0x106/0x140
> [  146.924970]  ? process_one_work+0x6e0/0x6e0
> [  146.929637]  ? kthread_bind+0x10/0x10
> [  146.933723]  ret_from_fork+0x3a/0x50
> [  146.937717]=20
> [  146.939377] Allocated by task 177:
> [  146.943170]  kasan_kmalloc+0x86/0xb0
> [  146.947158]  __kmalloc_node+0x181/0x430
> [  146.951438]  kvmalloc_node+0x4f/0x70
> [  146.955427]  alloc_bucket_spinlocks+0x34/0xa0
> [  146.960286]  bucket_table_alloc.isra.13+0x61/0x180
> [  146.965630]  rhashtable_rehash_alloc+0x26/0x80
> [  146.970585]  rht_deferred_worker+0x394/0x810
> [  146.975348]  process_one_work+0x24f/0x6e0
> [  146.979819]  worker_thread+0x4e/0x3d0
> [  146.983902]  kthread+0x106/0x140
> [  146.987502]  ret_from_fork+0x3a/0x50
> [  146.991487]=20
> [  146.993146] Freed by task 90:
> [  146.996455]  __kasan_slab_free+0x11d/0x180
> [  147.001025]  kfree+0x113/0x350
> [  147.004431]  bucket_table_free+0x1c/0x70
> [  147.008806]  rcu_process_callbacks+0x6c8/0x880
> [  147.013762]  __do_softirq+0xd5/0x505
> [  147.017747]=20
> [  147.019407] The buggy address belongs to the object at ffff881b6b934200
> [  147.019407]  which belongs to the cache kmalloc-8192 of size 8192
> [  147.033574] The buggy address is located 216 bytes inside of
> [  147.033574]  8192-byte region [ffff881b6b934200, ffff881b6b936200)
> [  147.046773] The buggy address belongs to the page:
> [  147.052116] page:ffffea006dae4c00 count:1 mapcount:0 mapping:ffff88010=
7c0e400 index:0x0 compound_mapcount: 0
> [  147.063086] flags: 0x17ffffc0008100(slab|head)
> [  147.068043] raw: 0017ffffc0008100 dead000000000100 dead000000000200 ff=
ff880107c0e400
> [  147.076684] raw: 0000000000000000 0000000000030003 00000001ffffffff 00=
00000000000000
> [  147.085324] page dumped because: kasan: bad access detected
> [  147.091540]=20
> [  147.093210] Memory state around the buggy address:
> [  147.098553]  ffff881b6b934180: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc
> [  147.106613]  ffff881b6b934200: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [  147.114670] >ffff881b6b934280: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [  147.122730]                                                     ^
> [  147.129527]  ffff881b6b934300: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [  147.137587]  ffff881b6b934380: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [  147.145646] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Reverting the above change avoid the issue.=20
>
> I *think* that reusing iter->p after a
> rcu_read_lock()/rcu_read_unlock() is unsafe:
> if the table has been reashed we can still and reuse 'p', but the
> related grace period could be already expired.

Thanks for the report.
It would be unsafe to dereference iter->p, but the code doesn't.
At least, it doesn't dereference it until it has searched through the
table and confirmed that the pointer is still in the table.

Could you please use scripts/faddr2line to identify exactly where the
error is occurring?
e.g
   ./scripts/faddr2line vmlinux.o inet_frag_worker+0x9f/0x210

(any .o which contains inet_frag_worker should work).
Thanks,
NeilBrown

>
> I can't think of any better fix than a revert. Other opinions welcome!
>
> Paolo

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAls+ogMACgkQOeye3VZi
gblPew/5AST8EU1fX5hTiEoqR1JAIUgVwarXIrX26zOQbAeKKB9AwPw5heYQAyAN
fiCCfI32mexTpfwMzMSRpCpwVyeLRDRR+C4NKoC5y6LGGAgKAjKgvg5oRhxyrYf2
QBdW3dUTzHyLMfpTG3KMvtw0Et14YfnpZDosG3HsUkgrTvCC+bI86rb04XlqZ5km
QR75yaSW3LgtDxAAAqeXp/UCRz/5QaFowvsxq3acNx7JB8tSTDh2Em8vl4YcXQEl
+QS7tTSyqUrgt8u1rEUg2UChDrewblQNgrBVm7po6ve3ZfVp1l6rziQDiHIgie9Q
E7e/gQqSh/QCWZDpdhje784ovaAQCC/EIXqWYkldQe++M+himgZ+cwJS3PkEsoO6
biaoWOZsAJK6WqVP0ccwXNJn2n0y4IJ8ZaxXzq3gWyRUvkPss/qI8Bvvm7OWQHJJ
4MluO92iy6wnamEz43saKehrjK1RXDWBcuEkT6kxPRFK8vF0e29v/RL0CGdkmB1r
CB/RuCvxnftcchKhPiP3T9zEd+rkG1SNSF3iaXe3lBnshe+3g10Hj8JWpP83i5Co
OvNqtn8XNYeVj1Fx/9/uFfGa9UwCuE2mQxgTlZJO+TgvkfillS4H9fr4juWAH9Po
zDAWxm3YVXV1MBUUjXW0Sr11+SkzxRhEi8qpyiddZ+CF9ceCUEY=
=mUQ9
-----END PGP SIGNATURE-----
--=-=-=--
