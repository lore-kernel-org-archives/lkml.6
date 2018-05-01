Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756159AbeEAQpi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:45:38 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:45541 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbeEAQpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:45:36 -0400
X-Google-Smtp-Source: AB8JxZownLL1TTM7OZtzaOzJyevPRYACYkcGSsgqvZ9K9sR8+XCSI5Th4d3NQV9LjVffBX+EuJyJ8Q==
Date: Tue, 1 May 2018 09:45:34 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: Doug Anderson <dianders@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v6 05/10] drivers: qcom: rpmh-rsc: write sleep/wake
 requests to TCS
Message-ID: <20180501164534.GE133494@google.com>
References: <20180419221635.17849-6-ilina@codeaurora.org>
 <20180425214111.GC243180@google.com>
 <20180427173943.GD6380@codeaurora.org>
 <20180427184017.GI243180@google.com>
 <20180427194559.GE6380@codeaurora.org>
 <20180427200605.GJ243180@google.com>
 <20180427213201.GA23157@codeaurora.org>
 <20180427215449.GA133494@google.com>
 <CAD=FV=Wan0G_GG29Q-atBbQS+_7nnbqTndE+yyi_G=scOdGMFA@mail.gmail.com>
 <20180501161010.GB23157@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180501161010.GB23157@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lina,

On Tue, May 01, 2018 at 10:10:10AM -0600, Lina Iyer wrote:
> On Fri, Apr 27 2018 at 17:24 -0600, Doug Anderson wrote:
> > Hi,
> > 
> > On Fri, Apr 27, 2018 at 2:54 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > > > > Am I getting something wrong here?
> > > > 
> > > > The for_each_set_bit() should increment the 'i' and we would attempt to
> > > > compare the first address in the request with the next command in the
> > > > TCS cache. If they don't match we repeat the process again. If it does,
> > > > then we loop through 'j' to find if the sequence matches.
> > > > 
> > > > Did I miss something?
> > > 
> > > One of us is clearly in need of more caffeine or ready for the
> > > weekend, it might be me :) Maybe another pair of eyeballs could help
> I need them both. Sorry about the back and forth. I understand what the
> problem is. The code doesnt look right. I seem to have messed it up.
> Thanks Matthias for being patient and going through this.
> 
> > > to resolve this deadlock ...
> > > 
> > > My single stepping above assumes that tcs->cmd_cache[i] matches
> > > cmd[0].addr, i.e. we either found the start of the sequence we are
> > > looking for or another sequence that starts with the same address. My
> > > claim is that the code returns i in either case, whether the
> > > subsequent addresses match or not.
> > 
> > I haven't reviewed this patch in detail, but I attempted to be another
> > pair of eyes here.  Something is definitely wrong with the "for (j =
> > 0; j < len; j++)" loop.  I believe the code that's written right now
> > is equivalent to this much shorter function:
> > 
> > +static int find_match(const struct tcs_group *tcs, const struct tcs_cmd *cmd,
> > +                     int len)
> > +{
> > +       int i, j;
> > +
> > +       /* Check for already cached commands */
> > +       for_each_set_bit(i, tcs->slots, MAX_TCS_SLOTS) {
> > +               if (tcs->cmd_cache[i] == cmd[0].addr)
> > +                       return i;
> > +       }
> > +
> > +       return -ENODATA;
> > +}
> > 
> > Specifically the test "if (tcs->cmd_cache[i] != cmd[0].addr)" does not
> > take "j" into account.  Thus if it was false when "j == 0" it will
> > continue to be false for "j == 1", "j == 2", etc.  Eventually you'll
> > hit the "else if (j == len - 1)" and return.
> > 
> > I believe that's what Matthias has been saying.  I personally haven't
> > looked at the rest of the patch to see how things out to be fixed, but
> > I'm quite convinced that the function either has a bug or should be
> > written as the shorter version I've written above.
> > 
> Yes, this is incorrect in its current form. This is what it should be -
> 
> static int find_match(const struct tcs_group *tcs, const struct tcs_cmd *cmd,
>                      int len)
> {
>        int i, j;
> 
>        /* Check for already cached commands */
>        for_each_set_bit(i, tcs->slots, MAX_TCS_SLOTS) {
>                if (tcs->cmd_cache[i] != cmd[0].addr)
>                        continue;

This looks better.

>                for (j = 0; j < len; j++) {
>                        WARN(tcs->cmd_cache[i + j] != cmd[j].addr,
>                             "Message does not match previous sequence.\n");
>                        return -EINVAL;
>                }

However this will return -EINVAL for any message in the first
iteration.

>                if (j == len - 1)
>                        return i;
>        }

You can just return 'i' here, 'j' will always be equals to 'len' (not
'len - 1') when this point is reached.

I think you want something like this:

  for (j = 0; j < len; j++) {
          if (tcs->cmd_cache[i + j] != cmd[j].addr) {
	          pr_warn("Message does not match previous sequence.\n");
                  return -EINVAL;
          }
  }

  return i;

Before entering the loop you also have to verify that 'i + (len - 1)'
doesn't exceed 'tcs->cmd_cache'.
