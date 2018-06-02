Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeFBD3P (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 23:29:15 -0400
Received: from www62.your-server.de ([213.133.104.62]:37216 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeFBD2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 23:28:53 -0400
Subject: Re: [PATCH bpf 1/2] bpf: fix alignment of netns_dev/netns_ino fields
 in bpf_{map,prog}_info
To: Song Liu <liu.song.a23@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>
Cc: netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Lawrence Brakmo <brakmo@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
References: <20180527112842.GA18204@asgard.redhat.com>
 <CAPhsuW4v=V0mbz07xe_shd68WP3BoV8iofxyVGApi+sL9kgzWQ@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e0bc258a-19c1-50bd-4cc6-a7d50be88169@iogearbox.net>
Date: Sat, 2 Jun 2018 05:28:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4v=V0mbz07xe_shd68WP3BoV8iofxyVGApi+sL9kgzWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 07:17 PM, Song Liu wrote:
> On Sun, May 27, 2018 at 4:28 AM, Eugene Syromiatnikov <esyr@redhat.com> wrote:
>> Recent introduction of netns_dev/netns_ino to bpf_map_info/bpf_prog info
>> has broken compat, as offsets of these fields are different in 32-bit
>> and 64-bit ABIs.  One fix (other than implementing compat support in
>> syscall in order to handle this discrepancy) is to use __aligned_u64
>> instead of __u64 for these fields.
>>
>> Reported-by: Dmitry V. Levin <ldv@altlinux.org>
>> Fixes: 52775b33bb507 ("bpf: offload: report device information about
>> offloaded maps")
>> Fixes: 675fc275a3a2d ("bpf: offload: report device information for
>> offloaded programs")
>>
>> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
>> ---
>>  include/uapi/linux/bpf.h       | 8 ++++----
>>  tools/include/uapi/linux/bpf.h | 8 ++++----
>>  2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index c5ec897..903010a 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1017,8 +1017,8 @@ struct bpf_prog_info {
>>         __aligned_u64 map_ids;
>>         char name[BPF_OBJ_NAME_LEN];
>>         __u32 ifindex;
>> -       __u64 netns_dev;
>> -       __u64 netns_ino;
>> +       __aligned_u64 netns_dev;
>> +       __aligned_u64 netns_ino;
>>  } __attribute__((aligned(8)));
> 
> Shall we add a __u32 padding variable before netns_dev? We can use it
> for in the future.

Agree with Song, and definitely prefer that approach since we already use the hole
as a bitfield in net-next; like this https://patchwork.ozlabs.org/patch/924415/.
