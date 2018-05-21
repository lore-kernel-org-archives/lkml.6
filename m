Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeEULLt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:11:49 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45895 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeEULLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:11:45 -0400
X-Google-Smtp-Source: AB8JxZoYVN74oi3OG2hJdu5Lt0ZWE5J32eeOJY9QVxmE2wraNM0C3dC1SSm83Iji88J7SyJwUuMyOcTXBFTT5+q6dvg=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KT0PAS8=bqHeSux3XwUx4fwKKqQoJkGeXRo8DHtEQNrDQ@mail.gmail.com>
References: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
 <1526537830-22606-4-git-send-email-yamada.masahiro@socionext.com>
 <CAFkk2KQUps1rhjxdOVz5Mkt+p7VkHX+o5aHvP3u0Hka0_ULcow@mail.gmail.com>
 <CAK7LNARP2b=jN_ioj3dT=3yiSTv7Ezu-MSPuh0vO30irN5D1nA@mail.gmail.com> <CAFkk2KT0PAS8=bqHeSux3XwUx4fwKKqQoJkGeXRo8DHtEQNrDQ@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 21 May 2018 13:11:44 +0200
Message-ID: <CAFkk2KT1zuMoA4=B+j6H2E=4wAtMdu9qQwxsZZSVaLM3VOwspQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/31] kconfig: reference environment variables
 directly and remove 'option env='
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 1:06 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> On Mon, May 21, 2018 at 6:43 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Hi.
>>
>>
>>
>> 2018-05-21 0:46 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>>
>>> s/environments/environment variables/
>>
>> Will fix.
>>
>>
>>>
>>>> +        * They will be written out to include/config/auto.conf.cmd
>>>> +        */
>>>> +       env_add(name, value);
>>>> +
>>>> +       return xstrdup(value);
>>>> +}
>>>> +
>>>> +void env_write_dep(FILE *f, const char *autoconfig_name)
>>>> +{
>>>> +       struct env *e, *tmp;
>>>> +
>>>> +       list_for_each_entry_safe(e, tmp, &env_list, node) {
>>>> +               fprintf(f, "ifneq \"$(%s)\" \"%s\"\n", e->name, e->value);
>>>> +               fprintf(f, "%s: FORCE\n", autoconfig_name);
>>>> +               fprintf(f, "endif\n");
>>>> +               env_del(e);
>>>> +       }
>>>> +}
>>>> +
>>>> +static char *eval_clause(const char *in)
>>>> +{
>>>> +       char *res, *name;
>>>> +
>>>> +       /*
>>>> +        * Returns an empty string because '$()' should be evaluated
>>>> +        * to a null string.
>>>> +        */
>>>
>>> Do you know of cases where this is more useful than erroring out?
>>>
>>> Not saying it doesn't make sense. Just curious.
>>
>>
>> I just followed how Make works.
>>
>> Anyway, eval_clause() will return null string for null input.
>> I will remove that hunk.
>>
>>
>>
>>
>>>> +       if (!*in)
>>>> +               return xstrdup("");
>>>> +
>>>> +       name = expand_string(in);
>>>> +
>>>> +       res = env_expand(name);
>>>> +       free(name);
>>>> +
>>>> +       return res;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Expand a string that follows '$'
>>>> + *
>>>> + * For example, if the input string is
>>>> + *     ($(FOO)$($(BAR)))$(BAZ)
>>>> + * this helper evaluates
>>>> + *     $($(FOO)$($(BAR)))
>>>> + * and returns the resulted string, then updates 'str' to point to the next
>>>
>>> s/resulted/resulting/
>>>
>>> Maybe something like this would make the behavior a bit clearer:
>>>
>>>   ...and returns a new string containing the expansion, also advancing
>>>   'str' to point to the next character after... (note that this function does
>>>   a recursive expansion) ...
>>
>>
>> Is this OK?
>>
>> /*
>>  * Expand a string that follows '$'
>>  *
>>  * For example, if the input string is
>>  *     ($(FOO)$($(BAR)))$(BAZ)
>>  * this helper evaluates
>>  *     $($(FOO)$($(BAR)))
>>  * and returns a new string containing the expansion (note that the string is
>>  * recursively expanded), also advancing 'str' to point to the next character
>>  * after the corresponding closing parenthesis, in this case, *str will be
>>  *     $(BAR)
>>  */
>
> Looks fine to me.
>
>>
>>
>>
>>>> + * character after the corresponding closing parenthesis, in this case, *str
>>>> + * will be
>>>> + *     $(BAR)
>>>> + */
>>>> +char *expand_dollar(const char **str)
>>>> +{
>>>> +       const char *p = *str;
>>>> +       const char *q;
>>>> +       char *tmp, *out;
>>>> +       int nest = 0;
>>>> +
>>>> +       /* '$$' represents an escaped '$' */
>>>> +       if (*p == '$') {
>>>> +               *str = p + 1;
>>>> +               return xstrdup("$");
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * Kconfig does not support single-letter variable as in $A
>>>> +        * or curly braces as in ${CC}.
>>>> +        */
>>>> +       if (*p != '(')
>>>> +               pperror("syntax error: '$' not followed by '('", p);
>>>
>>> Could say "not followed by '(' by or '$'".
>>
>> Will do.
>>
>>
>>>> +
>>>> +       p++;
>>>> +       q = p;
>>>> +       while (*q) {
>>>> +               if (*q == '(') {
>>>> +                       nest++;
>>>> +               } else if (*q == ')') {
>>>> +                       if (nest-- == 0)
>>>> +                               break;
>>>> +               }
>>>> +               q++;
>>>> +       }
>>>> +
>>>> +       if (!*q)
>>>> +               pperror("unterminated reference to '%s': missing ')'", p);
>>>> +
>>>> +       tmp = xmalloc(q - p + 1);
>>>> +       memcpy(tmp, p, q - p);
>>>> +       tmp[q - p] = 0;
>>>> +       *str = q + 1;
>>>> +       out = eval_clause(tmp);
>>>> +       free(tmp);
>>>> +
>>>> +       return out;
>>>
>>> This might be a bit clearer, since the 'str' update and the expansion
>>> are independent:
>>
>> Indeed, will do.
>>
>>>
>>>   /* Advance 'str' to after the expanded initial portion of the string */
>>>   *str = q + 1;
>>>
>>>   /* Save the "FOO" part of "(FOO)" into 'tmp' and expand it recursively */
>>>   tmp = xmalloc(q - p + 1);
>>>   memcpy(tmp, p, q - p);
>>>   tmp[q - p] = '\0';
>>>   out = eval_clause(tmp);
>>>   free(tmp);
>>>
>>>   return out;
>>>
>>> ...or switched around, but thought putting the 'str' bit first might
>>> emphasize that it isn't modified.
>>
>>
>> I prefer advancing the pointer at last.
>
> Yeah, it's a bit less weird in a way...
>
>>
>>
>>
>>
>>>> +}
>>>> +
>>>> +/*
>>>> + * Expand variables in the given string.  Undefined variables
>>>> + * expand to an empty string.
>>>
>>> I wonder what the tradeoffs are vs. erroring out here (or leaving
>>> undefined variables as-is).
>>
>>
>> I want to stick to the Make-like behavior here and exploit it in some cases.
>> We can set some variables in some arch/*/Kconfig,
>> but unset in the others.
>>
>>
>>
>>
>> In some arch/*/Kconfig:
>>
>> min-gcc-version := 40900
>>
>>
>>
>>
>> In init/Kconfig:
>>
>> # GCC 4.5 is required to build Linux Kernel.
>> # Some architectures may override it (from arch/*/Kconfig) for their
>> requirement.
>> min-gcc-version := $(if,$(min-gcc-version),$(min-gcc-version),40500)
>>
>> ... check the gcc version, then show error
>> if it is older than $(min-gcc-version).
>
> OK, makes sense. Fine by me.
>
>>>> + * The returned string must be freed when done.
>>>> + */
>>>> +char *expand_string(const char *in)
>>>> +{
>>>> +       const char *prev_in, *p;
>>>> +       char *new, *out;
>>>> +       size_t outlen;
>>>> +
>>>> +       out = xmalloc(1);
>>>> +       *out = 0;
>>>> +
>>>> +       while ((p = strchr(in, '$'))) {
>>>> +               prev_in = in;
>>>> +               in = p + 1;
>>>> +               new = expand_dollar(&in);
>>>> +               outlen = strlen(out) + (p - prev_in) + strlen(new) + 1;
>>>> +               out = xrealloc(out, outlen);
>>>> +               strncat(out, prev_in, p - prev_in);
>>>> +               strcat(out, new);
>>>> +               free(new);
>>>
>>> Some code duplication with expand_one_token() here. Do you think
>>> something could be factored out/reorganized?
>>
>>
>> Yes.  For example, the following would work.
>> If you prefer that, I can update it in v5.
>>
>>
>>
>>
>> static char *__expand_string(const char **str, bool (*is_end)(const char *))
>> {
>>         const char *in, *prev_in, *p;
>>         char *new, *out;
>>         size_t outlen;
>>
>>         out = xmalloc(1);
>>         *out = 0;
>>
>>         p = in = *str;
>>
>>         while (1) {
>>                 if (*p == '$') {
>>                         prev_in = in;
>>                         in = p + 1;
>>                         new = expand_dollar(&in);
>>                         outlen = strlen(out) + (p - prev_in) + strlen(new) + 1;
>>                         out = xrealloc(out, outlen);
>>                         strncat(out, prev_in, p - prev_in);
>>                         strcat(out, new);
>>                         free(new);
>>                         p = in;
>>                         continue;
>>                 }
>>
>>                 if (is_end(p))
>>                         break;
>>
>>                 p++;
>>         }
>>
>>         outlen = strlen(out) + (p - in) + 1;
>>         out = xrealloc(out, outlen);
>>         strncat(out, in, p - in);
>>
>>         *str = p;
>>
>>         return out;
>> }
>>
>> static bool is_end_of_str(const char *s)
>> {
>>         return !*s;
>> }
>>
>> char *expand_string(const char *in)
>> {
>>         return __expand_string(&in, is_end_of_str);
>> }
>>
>> static bool is_end_of_token(const char *s)
>> {
>>         return !(isalnum(*s) || *s == '_' || *s == '-' || *s == '.' ||
>> *s == '/');
>> }
>>
>> char *expand_one_token(const char **str)
>> {
>>         return __expand_string(str, is_end_of_token);
>> }
>
> Yep, something like that would be nicer I think.
>
> This variant might work too (untested):
>
>   dollar_i = p;

dollar_p makes more sense.

Cheers,
Ulf
