Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx49HjSR+AxWY/dwgpwZ5t1hFuuYme9z9PR4/KNrQ3A7ptTLDA6LWBuLzH0mgMaLMxE7Ff2wJ
ARC-Seal: i=1; a=rsa-sha256; t=1524499285; cv=none;
        d=google.com; s=arc-20160816;
        b=OAV4iKdPuE+ah+Onr4Rre6P5WFrsPsrfCl5eWc/EvZ4tZVC/yGJrS8IavDeYtJzj1w
         Z9c6zq8tUkMgjiTBZExuI/NCj12ILoqZvKfokLoQLvmrz9XewJDSp5V3FPF8Rv0OnGK/
         FBBsHBOvJoToj1+R1OBIkoEl+SBnQ2neBK69lPjkEwVfONzrgVFQEv5cThIAWwwpKllB
         S5MEt1IvdISb8HiDzm2cRUqYALBRHLhraQd+/IcGD9GZxqft3Cbt/0yz2H3/w5ynRDhG
         rC7FRsSBjDdshgTSEcUFqiwFcBMbu2a1XDwG7hgph5io89uN6sttZRJDO4A7NkQbOP1o
         G6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=9t2u373DxlwvYEfq8xr7r6MAqyYiDxrlmNbWkdeIlT4=;
        b=o7/gvixb+LqqPENjTMuNBXdA0hfVofvtaipKQ4FJ+2oftm4ve2LO8fM+goXMJcosPw
         INKlsVq0dswE8GVvl4z4iCLzST/IoIyVmRAA+8lSWToDnDlVvDLW9UpeDQl6V21wQgGC
         tDFRx91Ys3IIg6y0ed6GL6tFRgD6Ya1iUZwg5kfkxyPmRSHFuxjGkOMuSX47sP84jzQ3
         BOP4SY2T3L87ou/Z5mlBtACIhRFnQf+y3iQvWZMEOpKu0+8Qv5bnJwNUOdnjmapemFKl
         If5vtT39XwNZacMTpqlK/IxyxZI6aJzeK21qjktuAxZ1gC4vKYScW4O6KSIGIZig6TDU
         /Q0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: Re: INFO: rcu detected stall in n_tty_receive_char_special
To: gregkh@linuxfoundation.org, jslaby@suse.com,
        Peter Hurley <peter@hurleysoftware.com>
Cc: dvyukov@google.com,
        syzbot <syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <883d24f7d4ccc52e19056928c5be@google.com>
 <001a113f8d5cab39bd0569e3482a@google.com>
 <93a0c663-bbcf-0779-5606-6eeda644f8b9@I-love.SAKURA.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <e7a78d54-20c8-773d-e2aa-b6ad066a1fca@I-love.SAKURA.ne.jp>
Date: Tue, 24 Apr 2018 01:01:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <93a0c663-bbcf-0779-5606-6eeda644f8b9@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596979907220664835?=
X-GMAIL-MSGID: =?utf-8?q?1598553362883744990?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018/04/22 0:34, Tetsuo Handa wrote:
> Dmitry Vyukov wrote:
>> This looks somewhat similar to "INFO: rcu detected stall in __process_echoes":
>> https://syzkaller.appspot.com/bug?id=17f23b094cd80df750e5b0f8982c521ee6bcbf40
>> But I am not sure because stall stacks are somewhat different.
> 
> Yes, this will be the same one which can be reproduced using same reproducer
> provided by syzbot. You can try below one like "while :; do echo -n .; ./a.out; done".
> 
> ----------------------------------------
> #include <fcntl.h>
> #include <stdio.h>
> #include <sys/ioctl.h>
> #include <sys/stat.h>
> #include <unistd.h>
> 
> int main(int argc, char *argv[])
> {
> 	int fd[2];
> 	unsigned int zero = 0;
> 	char buf[128];
> 	int ptyno = 0;
> 	char c = 0;
> 	char data[64] = { };
> 	while (1) {
> 		fd[0] = open("/dev/ptmx", O_RDWR);
> 		ioctl(fd[0], TIOCSPTLCK, &zero);
> 		write(fd[0], data, sizeof(data));
> 		if (ioctl(fd[0], TIOCGPTN, &ptyno))
> 			break;
> 		sprintf(buf, "/dev/pts/%d", ptyno);
> 		fd[1] = open(buf, O_RDONLY);
> 		if (fd[1] == EOF)
> 			break;
> 		ioctl(fd[1], TIOCSTI, &c);
> 	}
> 	return 1;
> }
> ----------------------------------------

Bisection reached to commit e052c6d15c61cc4c ("tty: Use unbound workqueue
for all input workers") added in 4.4-rc1.

Reverting that commit on top of 4.4 solved the lockup. But unfortunately,
reverting that commit on top of 4.16 only helped surviving the test longer
than vanilla 4.16; still stalls at __process_echoes(). There might be similar
changes which need to be reverted as well.



# bad: [8005c49d9aea74d382f474ce11afbbc7d7130bec] Linux 4.4-rc1
# good: [6a13feb9c82803e2b815eca72fa7a9f5561d7861] Linux 4.3
# good: [64291f7db5bd8150a74ad2036f1037e6a0428df2] Linux 4.2
# good: [b953c0d234bc72e8489d3bf51a276c5c4ec85345] Linux 4.1
# good: [39a8804455fb23f09157341d3ba7db6d7ae6ee76] Linux 4.0
# good: [bfa76d49576599a4b9f9b7a71f23d73d6dcff735] Linux 3.19
# good: [b2776bf7149bddd1f4161f14f79520f17fc1d71d] Linux 3.18
# good: [bfe01a5ba2490f299e1d2d5508cbbbadd897bbe9] Linux 3.17
# good: [19583ca584d6f574384e17fe7613dfaeadcdc4a6] Linux 3.16
# good: [1860e379875dfe7271c649058aeddffe5afd9d0d] Linux 3.15
# good: [455c6fdbd219161bd09b1165f11699d6d73de11c] Linux 3.14
# good: [d8ec26d7f8287f5788a494f56e8814210f0e64be] Linux 3.13
# good: [5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52] Linux 3.12
git bisect start 'HEAD' 'v4.3' 'v4.2' 'v4.1' 'v4.0' 'v3.19' 'v3.18' 'v3.17' 'v3.16' 'v3.15' 'v3.14' 'v3.13' 'v3.12' '--' 'drivers/tty/'
# good: [cc32382d9fd22dc8eebba4a245f50417267bda8e] serial: imx: make setup_ufcr more useful
git bisect good cc32382d9fd22dc8eebba4a245f50417267bda8e
# good: [32ede4a51754cb62b0d43d91cb7c4e3c57069a9c] serial: tegra: Add helper function for handling RX buffer
git bisect good 32ede4a51754cb62b0d43d91cb7c4e3c57069a9c
# good: [4b41b9539a1e9531f942ededfcdcff372317d2e7] tty: Prevent tty teardown during tty_write_message()
git bisect good 4b41b9539a1e9531f942ededfcdcff372317d2e7
# bad: [fd0d351de7bbd718bc2b34d5846854831aa2b88c] Merge tag 'tty-4.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect bad fd0d351de7bbd718bc2b34d5846854831aa2b88c
# good: [14c79092909a52b6fd6394b6ad5e7756c4f9565e] Merge branch 'parisc-4.3-2' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
git bisect good 14c79092909a52b6fd6394b6ad5e7756c4f9565e
# good: [41ecf1404b34d9975eb97f5005d9e4274eaeb76a] Merge tag 'for-linus-4.4-rc0-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
git bisect good 41ecf1404b34d9975eb97f5005d9e4274eaeb76a
# bad: [e052c6d15c61cc4caff2f06cbca72b183da9f15e] tty: Use unbound workqueue for all input workers
git bisect bad e052c6d15c61cc4caff2f06cbca72b183da9f15e
# good: [e176058f0de53c2346734e5254835e0045364001] tty: Abstract tty buffer work
git bisect good e176058f0de53c2346734e5254835e0045364001
# first bad commit: [e052c6d15c61cc4caff2f06cbca72b183da9f15e] tty: Use unbound workqueue for all input workers
