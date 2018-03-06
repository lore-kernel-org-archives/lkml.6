Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933020AbeCFWIJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:08:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753805AbeCFWIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:08:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D32206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Lina Iyer <ilina@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180306162140.GC4930@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
References: <20180226175802.20052-1-ilina@codeaurora.org>
 <20180226175802.20052-2-ilina@codeaurora.org>
 <152027534725.108663.13213325833387672227@swboyd.mtv.corp.google.com>
 <20180306162140.GC4930@codeaurora.org>
Message-ID: <152037408636.218381.16707810584982252283@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 1/2] drivers: qcom: add command DB driver
Date: Tue, 06 Mar 2018 14:08:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-03-06 08:21:40)
> On Mon, Mar 05 2018 at 11:42 -0700, Stephen Boyd wrote:
> >Quoting Lina Iyer (2018-02-26 09:58:01)
> 
> >> +}
> >> +EXPORT_SYMBOL(cmd_db_ready);
> >> +
> >> +static u64 cmd_db_get_u64_id(const char *id)
> >> +{
> >> +       u64 rsc_id = 0;
> >> +       u8 *ch = (u8 *)&rsc_id;
> >> +       int i;
> >> +
> >> +       for (i = 0; i < sizeof(rsc_id) && id[i]; i++)
> >> +               ch[i] = id[i];
> >
> >This could be a strncpy now? Didn't I already ask this? I'll have to
> >look back at the other emails it seems. Actually, it looks like a cast
> >of a string to an integer,
> Yes, you did ask. The cast helps do an integer comparison as opposed to
> string comparision on the database.
> 
> >which is then reversed to look up the same
> >string. Not sure what the use is for this.
> >
> Where do you see that?

Hmm no idea. I must have seen something wrong. Ignore this one.

> 
> >> +
> >> +       return rsc_id;
> >> +}
> >> +
> >> +static int cmd_db_get_header(u64 query, struct entry_header *eh,
> >> +                           struct rsc_hdr *rh)
> >> +{
> >> +       struct rsc_hdr *rsc_hdr;
> >> +       struct entry_header *ent;
> >> +       int ret, i, j;
> >> +
> >> +       ret = cmd_db_ready();
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       if (!eh || !rh)
> >> +               return -EINVAL;
> >> +
> >> +       for (i = 0; i < MAX_SLV_ID; i++) {
> >> +               rsc_hdr = &cmd_db_header->header[i];
> >> +               if (!rsc_hdr->slv_id)
> >> +                       break;
> >> +
> >> +               ent = ENTRY_HEADER(rsc_hdr);
> >> +               for (j = 0; j < rsc_hdr->cnt; j++, ent++) {
> >> +                       if (ent->id == query)
> >> +                               break;
> >> +               }
> >> +
> >> +               if (j < rsc_hdr->cnt) {
> >> +                       memcpy(eh, ent, sizeof(*ent));
> >> +                       memcpy(rh, rsc_hdr, sizeof(*rh));
> >
> >I suppose it's OK to punt on the endian issues for now if it's too hard.
> >Eventually we'll want to handle it though and it shouldn't make the code
> >any worse when endianness is the same. Can it be done now?
> >
> Why is the change in endian needed? We can always add that in later if
> we decide to change the default endian. I would prefer that we punt it
> for now.

Ok!

> 
> >> +               ret = PTR_ERR(start_addr);
> >> +               goto done;
> >> +       }
> >> +
> >> +       cmd_db_header = start_addr;
> >> +       if (cmd_db_header->magic_num != CMD_DB_MAGIC) {
> >
> >memcmp?
> >
> Why? It could be a simple comparison.

Endian stuff again

> 
> >> +               ret = -EINVAL;
> >> +               dev_err(&pdev->dev, "Invalid Command DB Magic\n");
> >> +               goto done;
> >> +       }
> >> +
> >> +done:
> >> +       devm_memunmap(&pdev->dev, dict);
> >
> >I'm lost why we use devm_*() for this mapping.
> >
> Must have picked it up from an example. Curious, why not though?

devm is usually used for long lived things that need to be released on
driver removal. At least that's the way I view it. For short lived
things that are created and then freed in the same scope I usually avoid
devm.
